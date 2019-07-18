//
//  OpencvWrapper.h
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




NS_ASSUME_NONNULL_BEGIN

@interface OpencvWrapper : NSObject
-(instancetype)initWithViewController:(UIViewController*)vc andImageView:(UIImageView*)iv andSubImageView:(UIImageView*)siv;
-(void)startVideoCamera;
-(void)stopVideoCamera;
@end

NS_ASSUME_NONNULL_END
