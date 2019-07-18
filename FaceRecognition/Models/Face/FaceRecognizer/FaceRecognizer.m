//
//  Recognizer.m
//  FaceRecognition
//
//  Created by 조기현 on 06/07/2019.
//  Copyright © 2019 none. All rights reserved.
//
#import "opencv2/face/facerec.hpp"
#import "FaceRecognizer.h"

@implementation FaceRecognizer
{
    Ptr<cv::face::LBPHFaceRecognizer> model;
}

@end
