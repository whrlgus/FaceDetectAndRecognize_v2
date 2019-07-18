//
//  Recognizer.m
//  FaceRecognition
//
//  Created by 조기현 on 06/07/2019.
//  Copyright © 2019 none. All rights reserved.
//
#import "opencv2/face/facerec.hpp"
#import "FaceRecognizer.h"

using namespace cv;
using namespace std;
@implementation FaceRecognizer
{
    Ptr<cv::face::LBPHFaceRecognizer> model;
    int newLabel;
}

-(instancetype)init{
    if(self = [super init]){
        model = cv::face::LBPHFaceRecognizer::create();
        newLabel = 0;
    }
    return self;
}

-(void)train:(std::vector<cv::Mat> &)face{
    NSLog(@"학습 시작");
    vector<int> label(face.size(), newLabel++);
    if(newLabel==1)
        model->train(face, label);
    else model->update(face, label);
    face.clear();
    NSLog(@"학습 끝");
}

-(void)predict:(cv::Mat &)face{
    if(newLabel==0){
        NSLog(@"학습 모델 없음");
        return;
    }
    int predicted_label;
    double predicted_confidence;
    model->predict(face, predicted_label, predicted_confidence);
    NSLog(@"%d",predicted_label);
}

@end
