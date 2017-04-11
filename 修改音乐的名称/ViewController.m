//
//  ViewController.m
//  修改音乐的名称
//
//  Created by weidong liu on 2017/3/18.
//  Copyright © 2017年 weidong liu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *oldpath = @"/Users/weidongliu/Desktop/done";//旧音乐文件夹位置
    NSString *newPath = @"/Users/weidongliu/Desktop/done2";//改名后存放的文件夹
    
    BOOL isDir = NO;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:oldpath isDirectory:&isDir];
    
    BOOL isDir2 = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:newPath isDirectory:&isDir2]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:nil attributes:nil error:nil];
    }
    
    if (exist) {
        NSArray *arr = [[NSFileManager defaultManager] subpathsAtPath:oldpath];
        for (NSString *subPath in arr) {
            NSString *path = [NSString stringWithFormat:@"%@/%@", oldpath,subPath];
            NSURL *url = [NSURL fileURLWithPath:path];
            AVURLAsset *set = [AVURLAsset URLAssetWithURL:url options:nil];
            for (NSString *format in set.availableMetadataFormats) {
                for (AVMetadataItem *dataItem in [set metadataForFormat:format]) {
                    if ([dataItem.commonKey isEqualToString:@"title"]) {
                        NSLog(@"%@", dataItem.value);
                        NSData *data = [NSData dataWithContentsOfFile:path];
                        NSString *newName = [NSString stringWithFormat:@"%@/%@.mp3",newPath,dataItem.value];
                        if (![[NSFileManager defaultManager] fileExistsAtPath:newName]) {
                            [[NSFileManager defaultManager] createFileAtPath:newName contents:data attributes:nil];
                        }

                    }
                }
            }
            
        }
    }
    
    
}


@end
