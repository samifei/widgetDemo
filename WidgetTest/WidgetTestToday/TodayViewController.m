//
//  TodayViewController.m
//  WidgetTestToday
//
//  Created by ttxc on 2017/6/29.
//  Copyright © 2017年 TTXC. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)goAPP:(id)sender {
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.cpicorp"];
    //点击按钮更改数字并保存到
    int testNumber = [shared integerForKey:@"widget"];
    if (testNumber > 0) {
        testNumber += 1;
    }else
    {
        testNumber = 1;
    }
    [shared setInteger:testNumber forKey:@"widget"];
    [shared synchronize];
    //通过extensionContext借助host app调起app
    [self.extensionContext openURL:[NSURL URLWithString:@"widgetsam://sam"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d 🐒 %d",success ,testNumber);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //添加折叠效果
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    //理论上应该一直是更新的显示东西吧！？
    completionHandler(NCUpdateResultNewData);
}
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    /**
     iOS10以后，重新规定了Today Extension的size。宽度是固定(例如在iPhone6上是359)，所以无法改变；但是高度方面，提供了两种模式：
     
     NCWidgetDisplayModeCompact：固定高度，则为110
     
     NCWidgetDisplayModeExpanded：可以变化的高度，区间为110~616
     */
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    } else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    }
}

@end
