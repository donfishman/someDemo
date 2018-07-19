//
//  VideoViewController.m
//  HandBook
//
//  Created by 唐仁于 on 2018/6/3.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "VideoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self isVideoRecordingAvaialble]) {
        return;
    }
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.mediaTypes = @[(NSString *)kUTTypeMovie];
    self.delegate = self;
    
    
    self.showsCameraControls = YES;
    [self useingFrontCamera:NO];
    self.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    
    self.videoMaximumDuration = 20;
    
//     Do any additional setup after loading the view.
}

-(BOOL)isVideoRecordingAvaialble
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSArray *avilableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        
        if ([avilableMediaTypes containsObject:(NSString *)kUTTypeMovie]) {
            return YES;
        }
    }
    return NO;
}

-(void)useingFrontCamera:(BOOL)choose
{
    if (choose) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            [self setCameraDevice:UIImagePickerControllerCameraDeviceFront];
        }else{
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                [self setCameraDevice:UIImagePickerControllerCameraDeviceRear];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
