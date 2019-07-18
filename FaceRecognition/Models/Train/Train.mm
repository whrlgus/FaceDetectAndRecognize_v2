//
//  Train.m
//  FaceRecognition
//
//  Created by 조기현 on 07/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import "Train.h"
#import "Face.h"
#import "opencv2/imgcodecs/ios.h"

using namespace cv;
using namespace std;
@interface Train()<FaceDelegate>

@end

@implementation Train{
    UIImageView* subImageView;
    Face* face;
    vector<cv::Mat> trainData;
    UIViewController<TrainDelegate>* delegate;
    dispatch_semaphore_t semaphore;

}

-(instancetype)initWithViewController:(UIViewController<TrainDelegate>*)vc andImageView:(UIImageView*)iv andSubImageView:(UIImageView*)siv{
    if(self = [super init]){
        delegate = vc;
        face = [Face faceManager];
        [face setParentView:iv];
        face.delegate = self;
        
        subImageView = siv;
        [face startVideoCamera];
        
        semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

-(void) didFinishDetectFace:(cv::Rect &)faceRect andImage:(cv::Mat &)image{
    //dispatch_async(dispatch_get_main_queue(), ^{
        if(faceRect.empty()){
            dispatch_async(dispatch_get_main_queue(), ^{
                self->subImageView.image = nil;
            });
            return;
        }
        cv::Mat face(image.rows,image.cols,CV_8UC4, cv::Scalar(0,0,0,200));
        rectangle(face, faceRect, Scalar(0,0,0,0),FILLED);
    dispatch_async(dispatch_get_main_queue(), ^{
        self->subImageView.image = MatToUIImage(face);
    });
        cv::Mat faceMat;
        cvtColor(image(faceRect), faceMat, COLOR_RGB2GRAY);
        [self collectData:faceMat];
    //});
}

-(void)collectData:(cv::Mat&)faceMat{
    trainData.push_back(faceMat);
    NSLog(@"사진 %d 장",(int)trainData.size());
    if(trainData.size()==10){
        [face stopVideoCamera];
        
        // Doing: 이름 입력 받는 메소드 구현
        //NSString *tmp = @"zzz";
        NSString* name = [delegate getName];
        //dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        if(![name  isEqual: @""]) [face train:trainData andName:name];
        else NSLog(@"이름 미입력으로 train 취소");
        
        [delegate didFinishTrain];
    }
}

-(void)stop{
    [face stopVideoCamera];
}
@end
