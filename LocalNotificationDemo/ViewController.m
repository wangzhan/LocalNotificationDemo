//
//  ViewController.m
//  LocalNotificationDemo
//
//  Created by 王展 on 15/10/24.
//  Copyright © 2015年 王展. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startLocalNotification:(BOOL)action {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:30];
    notification.alertBody = @"content: hello world";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 2;
    notification.repeatInterval = 0;
    notification.userInfo = @{ @"source": @"james" };
    if (action) {
        notification.category = @"INVITE_CATEGORY";
        notification.alertBody = @"content: hello world, action";
    }
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (IBAction)actionNotificationButtonPressed:(id)sender {
    [self startLocalNotification:YES];
}

- (IBAction)normalNotificationButtonPressed:(id)sender {
    [self startLocalNotification:NO];
}


@end
