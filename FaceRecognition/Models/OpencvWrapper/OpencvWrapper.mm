//
//  OpencvWrapper.m
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import "OpencvWrapper.h"
#import "VideoCamera.h"
#import "FaceDetector.h"
#import "FaceRecognizer.h"
#import "opencv2/imgcodecs/ios.h"

using namespace cv;
using namespace std;

@interface OpencvWrapper()<CvVideoCameraDelegate,FaceDetectorDelegate>
@end

@implementation OpencvWrapper
{
    UIImageView* imageView, *subImageView;
    
    VideoCamera* videoCamera;
    FaceDetector* faceDetector;
    FaceRecognizer* faceRecognizer;
    
    cv::Mat image_copy;
    vector<cv::Rect> faceRect;
    
    bool isBusy;
    
}

-(void)startVideoCamera{
    [videoCamera startCamera];
}
-(void)stopVideoCamera{
    [videoCamera stopCamera];
}

-(instancetype)initWithViewController:(UIViewController *)vc andImageView:(UIImageView *)iv andSubImageView:(UIImageView*)siv{
    
    imageView = iv;
    subImageView = siv;
    videoCamera = [VideoCamera videoCameraManager];
    [videoCamera setParentView:iv];
    [videoCamera setDelegate:self];
    [self startVideoCamera];
    
    faceDetector = [[FaceDetector alloc] initWithDelegate:self];
    faceRecognizer = [[FaceRecognizer alloc] init];
    isBusy=false;
    
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
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self->faceRect.size()==1){
            cv::Mat face(self->image_copy.rows,self->image_copy.cols,CV_8UC4, cv::Scalar(0,0,0,200));
            rectangle(face, self->faceRect[0], Scalar(0,0,0,0),FILLED);
            self->subImageView.image = MatToUIImage(face);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(1);
            });
//            cvtColor(image, image, COLOR_BGR2GRAY);
//            self->subImageView.image = MatToUIImage(self->image_copy(faceRect[0]));
        }else{
            self->subImageView.image = nil;
        }
        self->isBusy=false;
    });
}

@end
