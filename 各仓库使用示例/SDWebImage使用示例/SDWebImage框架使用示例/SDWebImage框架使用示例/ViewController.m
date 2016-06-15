//
//  ViewController.m
//  SDWebImage框架使用示例
//
//  Created by wendingding on 16/6/15.
//  Copyright © 2016年 文顶顶. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImage+GIF.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self downlaod1];
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
}

//需求:1下载图片显示UI 2)内存缓存 3)磁盘缓存
-(void)downlaod1
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://d.3987.com/gxmbz_150209/desk_001.jpg"]];
}

//需求:1下载图片显示UI 2)内存缓存 3)磁盘缓存 4)监听图片下载进度
//下载图片的时候以渐进式的方式来显示|不做磁盘缓存
-(void)download2
{
    //    SDWebImageCacheMemoryOnly
    /*
     第一个参数:图片的url地址
     第二个参数:占位图片
     第三个参数:下载图片的特殊要求(选项)
     第四个参数:progress 进度回调block
     第五个参数:completed 完成后的回调
     */
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic4.nipic.com/20091113/3032379_164858607313_2.jpg"] placeholderImage:[UIImage imageNamed:@"Snip20160530_8"] options:SDWebImageProgressiveDownload | SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%f",1.0 *receivedSize / expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        switch (cacheType) {
            case SDImageCacheTypeNone:
                NSLog(@"直接下载图片");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"使用了磁盘缓存");
                break;
            case SDImageCacheTypeMemory:
                NSLog(@"使用了内存缓存");
                break;
            default:
                break;
        }
    }];
}
//需求:1下载图片不显示UI 2)内存缓存 3)磁盘缓存 4)监听图片下载进度
-(void)download3
{
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"http://pic4.nipic.com/20091113/3032379_164858607313_2.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%f",1.0 *receivedSize / expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        switch (cacheType) {
            case SDImageCacheTypeNone:
                NSLog(@"直接下载图片");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"使用了磁盘缓存");
                break;
            case SDImageCacheTypeMemory:
                NSLog(@"使用了内存缓存");
                break;
            default:
                break;
        }

    }];

}

//需求:1下载图片得到图片 不做内存缓存也不做缓存
-(void)download4
{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"http://pic4.nipic.com/20091113/3032379_164858607313_2.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%f",1.0 *receivedSize / expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {

        //!!!该block在子线程中处理
        //设置图片
        dispatch_async(dispatch_get_main_queue(), ^{

            self.imageView.image = image;
        });
    }];
}

-(void)gif
{
    //self.imageView.image = [UIImage imageNamed:@"test.gif"];
    self.imageView.image = [UIImage sd_animatedGIFNamed:@"test"];
}

@end
