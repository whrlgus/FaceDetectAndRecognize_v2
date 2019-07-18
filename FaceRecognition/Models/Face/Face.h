//
//  Face.h
//  FaceRecognition
//
//  Created by 조기현 on 07/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import "opencv2/opencv.hpp"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FaceDelegate <NSObject>

-(void)didFinishDetectFace:(cv::Rect&)faceRect andImage:(cv::Mat&)image;

@end

@interface Face : NSObject

@property (nonatomic, weak) id <FaceDelegate> delegate;
+ (instancetype) faceManager;
//-(instancetype)initWithViewController:(UIViewController*)vc andImageView:(UIImageView*)iv;
-(void)startVideoCamera;
-(void)stopVideoCamera;
-(void)setParentView:(UIView *)parentView;

-(void)predict;
-(void)train:(std::vector<cv::Mat>&)trainData andName:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
