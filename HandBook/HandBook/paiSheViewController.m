#import "paiSheViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface paiSheViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mImageview;

@property (nonatomic,assign) BOOL isTakeVedio;

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) AVPlayer *player;

@end

@implementation paiSheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"拍摄" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(takeVedio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePic:(id)sender {
    _isTakeVedio = NO;
    [self showPicker];
}

- (void)takeVedio{
    _isTakeVedio = YES;
    [self showPicker];
}



- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;    //设置来源为摄像头
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear; //设置使用的摄像头为：后置摄像头
        if (self.isTakeVedio) {
            _imagePicker.mediaTypes = @[(NSString *)kUTTypeVideo];    //设置为视频模式-<span style="color: rgb(51, 51, 51); font-family: Georgia, 'Times New Roman', Times, sans-serif; font-size: 14px; line-height: 25px;">注意媒体类型定义在MobileCoreServices.framework中</span>
            _imagePicker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;   //设置视频质量
            _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;  //设置摄像头模式为录制视频
        }
        else{
            _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto; //设置摄像头模式为拍照
        }
    }
    return _imagePicker;
}

- (void)showPicker
{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark-
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        //图片保存和展示
        UIImage *image;
        if (picker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage]; //允许编辑，获取编辑过的图片
        }
        else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage]; //不允许编辑，获取原图片
        }
        self.mImageview.image = image;
        UIImageWriteToSavedPhotosAlbum(image,nil,nil, nil);
    }
    else if([type isEqualToString:(NSString *)kUTTypeVideo]){
        //视频保存后 播放视频
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *urlPath = [url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlPath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(urlPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark-
#pragma mark - share method

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        //录制完之后自动播放
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        _player=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = self.mImageview.frame;
        [self.mImageview.layer addSublayer:playerLayer];
        [_player play];
    }
}

@end
