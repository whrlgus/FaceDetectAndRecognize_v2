//
//  VideoCamera.m
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//



#import "VideoCamera.h"

@implementation VideoCamera
{
    CvVideoCamera* cvVideoCamera;
}
#pragma mark - Singleton Methods
+ (instancetype) videoCameraManager{
    static VideoCamera *videoCamera = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoCamera = [[self alloc] initPrivate];
    });
    return videoCamera;
}

// 외부에서 인스턴스 생성 방지
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"..." userInfo:nil];
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        NSLog(@"VideoCamera 싱글톤 인스턴스 생성");
        // 초기화 코드 작성
        [self initVideoCamera];
    }
    return self;
}

-(void)initVideoCamera{
    cvVideoCamera = [[CvVideoCamera alloc] init];
    cvVideoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    cvVideoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    cvVideoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    cvVideoCamera.defaultFPS = 30;
}

-(void)setParentView:(UIView*)parentView{
    cvVideoCamera.parentView = parentView;
}
-(void)setDelegate:(id)delegate{
    cvVideoCamera.delegate = delegate;
}


#pragma mark - 기타
- (void)startCamera{
    [cvVideoCamera start];
}
- (void)stopCamera{
    [cvVideoCamera stop];
}

@end
