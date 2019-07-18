//
//  FaceDetect.m
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import "FaceDetector.h"
#import "opencv2/objdetect.hpp"

using namespace cv;
using namespace std;

@implementation FaceDetector
{
    CascadeClassifier faceCascade, eyeCascade;
    vector<cv::Rect> facesRect_with_low_prob,eyesRect_with_low_prob;
    id<FaceDetectorDelegate> delegate;
}

-(instancetype)initWithDelegate:(id<FaceDetectorDelegate>)delegate{
    if(self = [super init]){
        self->delegate = delegate;
        [self initCascadeClassifier];
    }
    return self;
}

#pragma mark 초기화 메소드
-(void)initCascadeClassifier{
    NSBundle * appBundle = [NSBundle mainBundle];
    NSString * cascadePathInBundle;
    
    cascadePathInBundle = [appBundle pathForResource: @"haarcascade_frontalface_default" ofType: @"xml"];
    string faceCascadePath([cascadePathInBundle UTF8String]);
    cascadePathInBundle = [appBundle pathForResource: @"haarcascade_eye" ofType: @"xml"];
    string eyeCascadePath([cascadePathInBundle UTF8String]);
    if (!faceCascade.load(faceCascadePath)||!eyeCascade.load(eyeCascadePath)) NSLog(@"Load error");
}

#pragma mark - 얼굴 검출 메소드
-(void)detectFace:(cv::Mat&)image andFaceRect:(vector<cv::Rect>&)faceRect{
    @try{
        facesRect_with_low_prob.clear();
        faceCascade.detectMultiScale(image, facesRect_with_low_prob);
        if(facesRect_with_low_prob.empty()){
            NSLog(@"발견된 얼굴 없음");
            return;
        }
        
        Mat croppedImage;
        eyesRect_with_low_prob.clear();
        for(auto& face: facesRect_with_low_prob){
            croppedImage = image(face);
            eyeCascade.detectMultiScale(croppedImage, eyesRect_with_low_prob);
            if(eyesRect_with_low_prob.size()<2){
                NSLog(@"자른 얼굴 이미지에서 발견된 눈이 없음");continue;
            }
            if(faceRect.size()>1){
                NSLog(@"두개 이상의 얼굴 발견");return;
            }
            faceRect.push_back(face);
        }
        if(faceRect.empty()){
            NSLog(@"발견된 얼굴 없음");
            return;
        }
        NSLog(@"한개의 얼굴 검출");
    }@finally{
        [delegate didFinishDetectFace];
    }
}
@end
