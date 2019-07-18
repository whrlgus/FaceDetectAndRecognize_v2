//
//  Predict.m
//  FaceRecognition
//
//  Created by 조기현 on 07/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

#import "opencv2/imgcodecs/ios.h"
#import "Predict.h"
#import "Face.h"

using namespace cv;

@interface Predict()<FaceDelegate>

@end

@implementation Predict{
    UIImageView* subImageView;
    Face* face;

}
-(instancetype)initWithViewController:(UIViewController*)vc andImageView:(UIImageView*)iv andSubImageView:(UIImageView*)siv{
    if(self = [super init]){
        face = [Face faceManager];
        [face setParentView:iv];
        face.delegate = self;
        
        subImageView = siv;
        [face startVideoCamera];
        

    }
    return self;
}

-(void) didFinishDetectFace:(cv::Rect&)faceRect andImage:(cv::Mat&)image{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(faceRect.empty())
            return;
        [self->face predict];
    });
}
-(void)stop{
    [face stopVideoCamera];
}

@end
