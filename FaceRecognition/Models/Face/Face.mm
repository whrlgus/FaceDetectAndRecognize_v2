//
//  Face.m
//  FaceRecognition
//
//  Created by 조기현 on 07/07/2019.
//  Copyright © 2019 none. All rights reserved.
//
#import "opencv2/opencv.hpp"
#import "Face.h"
#import "VideoCamera.h"
#import "FaceDetector.h"
#import "FaceRecognizer.h"

using namespace cv;
using namespace std;

@interface Face()<CvVideoCameraDelegate,FaceDetectorDelegate>
@end

@implementation Face
{
    VideoCamera* videoCamera;
    FaceDetector* faceDetector;
    FaceRecognizer* faceRecognizer;
    
    cv::Mat image_copy;
    vector<cv::Rect> faceRect;
    cv::Rect empty;
    cv::Mat faceMat;
    
    bool isBusy;
}

-(void)startVideoCamera{
    [videoCamera startCamera];
}
-(void)stopVideoCamera{
    [videoCamera stopCamera];
}
-(void)setParentView:(UIView*)parentView{
    [videoCamera setParentView:parentView];
}

#pragma mark - Singleton Methods
+ (instancetype) faceManager{
    static Face *face = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        face = [[self alloc] initPrivate];
    });
    return face;
}

// 외부에서 인스턴스 생성 방지
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"..." userInfo:nil];
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        NSLog(@"Face 싱글톤 인스턴스 생성");
        // 초기화 코드 작성
        videoCamera = [VideoCamera videoCameraManager];
        [videoCamera setDelegate:self];
        
        faceDetector = [[FaceDetector alloc] initWithDelegate:self];
        faceRecognizer = [[FaceRecognizer alloc] init];
        isBusy=false;
        
        return self;
    }
    return self;
}



- (void)processImage:(cv::Mat&)image {
    if(isBusy) return;
    
    isBusy=true;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image.copyTo(self->image_copy);
        self->faceRect.clear();
        [self->faceDetector detectFace:self->image_copy andFaceRect:self->faceRect];
    });
}

- (void)didFinishDetectFace {
    if(faceRect.size()==1)
        [self.delegate didFinishDetectFace:faceRect[0] andImage:image_copy];
    else
        [self.delegate didFinishDetectFace:empty andImage:image_copy];

    isBusy=false;
}

-(void)predict{
    cvtColor(image_copy(faceRect[0]), faceMat, COLOR_RGB2GRAY);
    [faceRecognizer predict:faceMat];
}
-(void)train:(vector<cv::Mat> &)trainData{
    [faceRecognizer train:trainData];
}



@end
