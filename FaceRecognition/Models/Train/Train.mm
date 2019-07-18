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
}

-(instancetype)initWithViewController:(UIViewController<TrainDelegate>*)vc andImageView:(UIImageView*)iv andSubImageView:(UIImageView*)siv{
    if(self = [super init]){
        delegate = vc;
        face = [Face faceManager];
        [face setParentView:iv];
        face.delegate = self;
        
        subImageView = siv;
        [face startVideoCamera];
    }
    return self;
}

-(void) didFinishDetectFace:(cv::Rect &)faceRect andImage:(cv::Mat &)image{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(faceRect.empty()){
            self->subImageView.image = nil;
            return;
        }
        cv::Mat face(image.rows,image.cols,CV_8UC4, cv::Scalar(0,0,0,200));
        rectangle(face, faceRect, Scalar(0,0,0,0),FILLED);
        self->subImageView.image = MatToUIImage(face);
        
        cv::Mat faceMat;
        cvtColor(image(faceRect), faceMat, COLOR_RGB2GRAY);
        [self collectData:faceMat];
    });
}

-(void)collectData:(cv::Mat&)faceMat{
    trainData.push_back(faceMat);
    NSLog(@"사진 %d 장",(int)trainData.size());
    if(trainData.size()==10){
        [face train:trainData];
        [self stop];
        [delegate didFinishTrain];
    }
}

-(void)stop{
    [face stopVideoCamera];
}
@end
