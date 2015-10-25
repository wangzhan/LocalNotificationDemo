//
//  AppDelegate.m
//  LocalNotificationDemo
//
//  Created by 王展 on 15/10/24.
//  Copyright © 2015年 王展. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerLocalNotification];
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (userInfo) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(重新启动)" message:@"launch" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(后台运行)" message:userInfo[@"source"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)application:(UIApplication *) application handleActionWithIdentifier: (NSString *) identifier forLocalNotification: (NSDictionary *) notification completionHandler: (void (^)()) completionHandler {
    
    if ([identifier isEqualToString: @"ACCEPT_IDENTIFIER"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(acceptAction)" message:identifier delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    // Must be called when finished
    completionHandler();
}


- (void)registerLocalNotification {
    
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    
    if (sysVersion>=8.0) {
        UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
        acceptAction.identifier = @"ACCEPT_IDENTIFIER";
        acceptAction.title = @"Accept";
        acceptAction.activationMode = UIUserNotificationActivationModeForeground;
        acceptAction.destructive = NO;
        acceptAction.authenticationRequired = YES;
        
        UIMutableUserNotificationAction *maybeAction = [[UIMutableUserNotificationAction alloc] init];
        maybeAction.identifier = @"MAYBE_IDENTIFIER";
        maybeAction.title = @"maybe";
        maybeAction.activationMode = UIUserNotificationActivationModeBackground;
        maybeAction.destructive = NO;
        maybeAction.authenticationRequired = NO;
        
        UIMutableUserNotificationAction *declineAction = [[UIMutableUserNotificationAction alloc] init];
        declineAction.identifier = @"DECLINE_IDENTIFIER";
        declineAction.title = @"decline";
        declineAction.activationMode = UIUserNotificationActivationModeBackground;
        declineAction.destructive = YES;
        
        // custom category
        UIMutableUserNotificationCategory *inviteCategory =
        [[UIMutableUserNotificationCategory alloc] init];
        inviteCategory.identifier = @"INVITE_CATEGORY";
        [inviteCategory setActions:@[acceptAction, maybeAction, declineAction]
                        forContext:UIUserNotificationActionContextDefault];
        [inviteCategory setActions:@[acceptAction, declineAction]
                        forContext:UIUserNotificationActionContextMinimal];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObject:inviteCategory]]];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound];
    }
}

@end
