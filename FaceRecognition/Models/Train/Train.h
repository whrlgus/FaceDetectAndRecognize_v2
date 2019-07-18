//
//  Train.h
//  FaceRecognition
//
//  Created by 조기현 on 07/07/2019.
//  Copyright © 2019 none. All rights reserved.
//
//#import "opencv2/opencv.hpp"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TrainDelegate
-(void)didFinishTrain;
@end
@interface Train : NSObject
-(instancetype)initWithViewController:(UIViewController*)vc andImageView:(UIImageView*)iv andSubImageView:(UIImageView*)siv;
-(void) stop;
@end

NS_ASSUME_NONNULL_END
