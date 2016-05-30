//
//  RootViewController.m
//  test
//
//  Created by joinus on 15/5/15.
//  Copyright (c) 2015年 joinus. All rights reserved.
//

#import "RootViewController.h"
#import "ZListBarScrollView.h"
#import "BDGImagePicker.h"
#import "BUKImagePickerController.h"
#import "ELCImagePickerController.h"
#import "HMImagePickerController.h"
#import "JFImagePickerController.h"
#import "TZImagePickerController.h"
#import "Masonry.h"
#import "AFHTTPSessionManager.h"
#import "TMBaseRequestDataModel.h"
#import "TMRequestBaseDataEngine.h"

#define kListBarH 30
#define kArrowW 40
#define kAnimationTime 0.8


//#ifdef DEBUG
//# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt),__FILE__,__FUNCTION__,__LINE__,##__VA_ARGS__);
//#else
# define DLog(...);
//#endif


@interface RootViewController ()<BUKImagePickerControllerDelegate,HMImagePickerControllerDelegate,JFImagePickerDelegate,TZImagePickerControllerDelegate>{
    UIView * view1;
    UIView * view2;
}
@property(nonatomic,strong)UIPageControl * PageControl;
@property (nonatomic,strong) ZListBarScrollView *listBar;
@property(nonatomic,strong) BDGImagePicker *imagePicker;
/// 选中照片数组
@property (nonatomic) NSArray *images;
/// 选中资源素材数组，用于定位已经选择的照片
@property (nonatomic) NSArray *selectedAssets;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float b = 4.32;
    
    double a = 88.0 - 30.6;
    
    NSLog(@"a ----  %d %%",(int)b);
    
    
    DLog(@"帅的哦");
    
    
    
    
    
    
    [self netWork];
    [self loadFile];
    
    NSError *error=nil;
    //    通过指定的路径读取文本内容
    
    NSString *str=[NSString stringWithContentsOfFile:@"/tmp/test.txt" encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"srt=%@",str);
    
    NSArray * array = [str componentsSeparatedByString:@" "];
    NSLog(@"arrray ------   %@",array);
    
    
    
    /*
    
    self.view.backgroundColor = [UIColor grayColor];

    
    NSMutableArray *listTop = [[NSMutableArray alloc] initWithArray:@[@"推荐",@"热点",@"杭州",@"社会",@"娱乐",@"科技",@"汽车",@"体育",@"订阅",@"财经",@"军事",@"国际",@"正能量",@"段子",@"趣图",@"美女",@"健康",@"教育",@"特卖",@"彩票",@"辟谣"]];

    __weak typeof(self) unself = self;

    if (!self.listBar) {
        self.listBar = [[ZListBarScrollView alloc] initWithFrame:CGRectMake(0,200, kScreenW, kListBarH)];
        self.listBar.visibleItemList = listTop;
        self.listBar.listBarItemClickBlock = ^(NSString *itemName , NSInteger itemIndex){
//            [unself.detailsList itemRespondFromListBarClickWithItemName:itemName];
            //添加scrollview
            
            //移动到该位置
//            unself.mainScroller.contentOffset =  CGPointMake(itemIndex * unself.mainScroller.frame.size.width, 0);
        };
        [self.view addSubview:self.listBar];
    }

    
    
    
    */
    
    
    /*
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"点我哦" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    */
    
    view1                       = [[UIView alloc] init];
    view1.backgroundColor       = [UIColor redColor];
    [self.view addSubview:view1];
    
    view2                       = [[UIView alloc] init];
    view2.backgroundColor       = [UIColor greenColor];
    [self.view addSubview:view2];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.centerX.equalTo(@0);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).insets(UIEdgeInsetsMake(20,20,20,20));
        make.centerX.equalTo(@0);
        make.width.equalTo(view1);
        make.height.equalTo(view1);
    }];
    
    
    [self performSelector:@selector(adadasd) withObject:self afterDelay:2.0f];
}

-(void)adadasd{
   
    
    [view1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
    }];
}

#pragma mark ---- 网络请求
-(void)netWork{
    
    AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
//    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager GET:@"http://202.108.31.66:8088/tmmobile/mobile/qrMovie?" parameters:@{@"movieId":@"20121212004"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"obj ----  %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error ----  %@",error);
    }];
    
    
//    NSURLSessionDataTask * task = [sessionManager POST:@"http://202.108.31.66:8088/tmmobile/mobile/qrMovie?"
//              parameters:@{@"movieId":@"20121212004"}
//                progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"task ----  %@",task);
//        NSData* data= (NSData *)responseObject;
//        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"获取到的数据为：%@",dict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error ----  %@",error);
//    }];
    
    
//    [task cancel];
    
    
    NSDictionary * dic = @{@"movieId":@"20121212004"};
    
    TMRequestBaseDataEngine * engine = [TMRequestBaseDataEngine control:self
                                path:@"http://yingmile.com/tmmobile/mobile/qrMovie?"
                               param:dic
                         requestType:TMManagerRequestTypeGet
                           alertType:DataEngineAlertType_ErrorView
                       progressBlock:^(NSProgress *taskProgress) {
                           NSLog(@"这么屌么 -----   %@",taskProgress);
    } complete:^(id data, NSError *error) {
        NSData* newData= (NSData *)data;
        id dict=[NSJSONSerialization  JSONObjectWithData:newData options:0 error:nil];
        NSLog(@"data ------  %@ -----  %@",dict,error);
    } errorButtonSelectIndex:^(NSUInteger buttonIndex) {
        
    }];
}
-(void)loadFile{
    
    
    
    /*
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://test.twttmob.com/Test_version/include/index_list.txt?%d",arc4random()%1000000]]];
    
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] init];
    
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
     {
         // 指定下载文件保存的路径
         //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
         // 将下载文件保存在缓存路径中
         NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
         NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
         
         // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
         NSURL *fileURL1 = [NSURL URLWithString:path];
         NSURL *fileURL = [NSURL fileURLWithPath:path];
         NSLog(@"== %@ |||| %@", fileURL1, fileURL);
         return fileURL;
    }completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    
    [task resume];
     */
}

-(void)buttonClick:(UIButton *)button{
    
    /*
    self.imagePicker = [BDGImagePicker new];
    self.imagePicker.allowsEditing = TRUE;
    self.imagePicker.title = NSLocalizedString(@"Photo", @"");
    [self.imagePicker setImagePicked:^(UIImage *image) {
        //Do something with the image!
    }];
    [self.imagePicker pickImageFromViewController:self];
    */
    
    /*
    BUKImagePickerController *imagePickerController = [[BUKImagePickerController alloc] init];
    imagePickerController.mediaType = BUKImagePickerControllerMediaTypeImage;
    imagePickerController.sourceType = BUKImagePickerControllerSourceTypeLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
     */
    
    /*
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] init];
    elcPicker.maximumImagesCount = 4; //Set the maximum number of images to select, defaults to 4
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;
    //Present modally
    [self presentViewController:elcPicker animated:YES completion:nil];
     */
    
    /*
    HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
    
    // 设置图像选择代理
    picker.pickerDelegate = self;
    // 设置目标图片尺寸
    picker.targetSize = CGSizeMake(600, 600);
    // 设置最大选择照片数量
    picker.maxPickerCount = 1;
    
    [self presentViewController:picker animated:YES completion:nil];
    */
    
    
    
    /*
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:self];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    */
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)buk_imagePickerController:(BUKImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    // Process assets
    
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    // 记录图像，方便在 CollectionView 显示
    self.images = images;
    // 记录选中资源集合，方便再次选择照片定位
    self.selectedAssets = selectedAssets;
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
