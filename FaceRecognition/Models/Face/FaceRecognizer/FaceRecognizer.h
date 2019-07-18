//
//  Recognizer.h
//  FaceRecognition
//
//  Created by 조기현 on 06/07/2019.
//  Copyright © 2019 none. All rights reserved.
//
#include "opencv2/core.hpp"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceRecognizer : NSObject
-(instancetype)init;
-(void)train:(std::vector<cv::Mat>&)face;
-(void)predict:(cv::Mat &)face;
@end

NS_ASSUME_NONNULL_END
