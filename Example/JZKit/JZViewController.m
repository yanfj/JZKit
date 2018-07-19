//
//  JZViewController.m
//  JZKit
//
//  Created by yanfj on 04/26/2018.
//  Copyright (c) 2018 yanfj. All rights reserved.
//

#import "JZViewController.h"
#import <JZKit/JZKit.h>
#import "ABInstance.h"
#import "CDInstance.h"

@interface JZViewController ()

@end

@implementation JZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self jz_registerNotification];
    
    [ABInstance sharedInstance];
    [CDInstance sharedInstance];
    
}
- (IBAction)button:(id)sender {
    
    [JZProgressHUD showStatus:@"准备中..."];

    //GCD
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //子线程执行

        sleep(1.5);

        float progress = 0.0f;

        while (progress < 1) {

            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程执行

                [JZProgressHUD showProgress:progress status:@"上传中..."];

            });

            progress += 0.01;

            usleep(50000);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程执行
            [JZProgressHUD showSuccessWithStatus:@"清理成功" completion:nil];

        });
    });
    
    
    
}


@end
