//
//  VideoCamera.h
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import "opencv2/opencv.hpp"
#import "opencv2/videoio/cap_ios.h"
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface VideoCamera : NSObject

//@property (nonatomic, weak) id delegate;
+ (instancetype) videoCameraManager;
- (void) startCamera;
- (void) stopCamera;


-(void) setParentView:(UIView *)parentView;
-(void) setDelegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
