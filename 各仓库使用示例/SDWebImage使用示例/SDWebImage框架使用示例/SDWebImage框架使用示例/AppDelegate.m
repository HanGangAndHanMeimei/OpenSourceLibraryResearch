//
//  AppDelegate.m
//  SDWebImage框架使用示例
//
//  Created by wendingding on 16/6/15.
//  Copyright © 2016年 文顶顶. All rights reserved.
//

#import "AppDelegate.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //清空内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];

    //取消当前所有的操作
    [[SDWebImageManager sharedManager] cancelAll];

    //实现细节
    /*
     1.clear|clean
     clearDisk :把之前的缓存文件全部删除,删除之后重新创建一个空的文件
     cleanDisk: 先删除过期的缓存文件,删除之后先计算当前剩余的缓存文件的大小,
     和设置的最大缓存进行比较,如果超出那么会继续删除(按照文件创建的时间)
     2.默认的过期时间 1周 kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week
     3.内存缓存处理方式:并不是使用可变字典 -->NSCache
     4.磁盘缓存的路径 ~/Library/Caches/default/com.hackemist.SDWebImageCache.default
     5.命名:根据图片的URL地址进行MD5加密,使用加密之后的密文来存储
     $ echo -n "http://d.3987.com/gxmbz_150209/desk_001.jpg" | md5
     6.下载图片的方式:NSURLConnection 发送网络请求来下载图片
     7.下载的超时时间:15秒
     8.downloadQueue.maxConcurrentOperationCount = 6
     9.怎么判断图片的类型:得到图片的二进制数据的第一个字节
     */
}

@end
