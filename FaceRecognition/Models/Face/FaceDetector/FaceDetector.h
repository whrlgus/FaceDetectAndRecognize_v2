//
//  FaceDetect.h
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//
#import "opencv2/opencv.hpp"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol FaceDetectorDelegate <NSObject>
-(void)didFinishDetectFace;
@end

@interface FaceDetector : NSObject

//@property (nonatomic, weak) id <FaceDetectorDelegate> delegate;
-(instancetype)initWithDelegate:(id<FaceDetectorDelegate>)delegate;
-(void)detectFace:(cv::Mat&)image andFaceRect:(std::vector<cv::Rect>&)faceRect;
@end

NS_ASSUME_NONNULL_END
