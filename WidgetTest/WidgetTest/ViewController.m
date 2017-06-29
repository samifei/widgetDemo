//
//  ViewController.m
//  WidgetTest
//
//  Created by ttxc on 2017/6/29.
//  Copyright © 2017年 TTXC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)changeBTN:(id)sender {
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.cpicorp"];
    int samNumber = [shared integerForKey:@"widget"];
    [shared synchronize];

    UIButton *btn = sender;
    [btn setTitle:[NSString stringWithFormat:@"%d",samNumber] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
