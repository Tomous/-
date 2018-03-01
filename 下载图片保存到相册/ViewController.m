//
//  ViewController.m
//  下载图片保存到相册
//
//  Created by wenhua on 2017/10/20.
//  Copyright © 2017年 wenhua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIImageView * imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *img = [[UIImageView alloc]init];
    
    [self DownLoadImageWithImageView:img WithX:40 WithY:100 WithWidth:300 WithHeight:200 WithUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493522326&di=029466d27bf17747d08988b093712982&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F12%2F22%2F94%2F37bOOOPICc7_1024.jpg"];
}

-(void)DownLoadImageWithImageView:(UIImageView *)imageView WithX:(CGFloat)x WithY:(CGFloat)y WithWidth:(CGFloat)width WithHeight:(CGFloat)height WithUrl:(NSString *)ImageUrl
{
    self.imageView = imageView;
    [imageView setFrame:CGRectMake(x, y, width, height)];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
    UIImage *image = [UIImage imageWithData:data];
    [imageView setImage:image];
    
    //1.创建长按手势
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imglongTapClick:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:longTap];
    
}

#pragma mark 长按手势弹出警告视图确认
-(void)imglongTapClick:(UILongPressGestureRecognizer*)gesture
{
    if(gesture.state==UIGestureRecognizerStateBegan)
    {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消保存图片");
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"确认保存图片");
            
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(self.imageView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
            
        }];
        
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self presentViewController:alertControl animated:YES completion:nil];
    }
}

#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError: (NSError*)error contextInfo:(id)contextInfo
{
    NSString*message =@" ";
    
    if(!error) {
        
        message =@"成功保存到相册";
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }else
    {
        message = [error description];
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
