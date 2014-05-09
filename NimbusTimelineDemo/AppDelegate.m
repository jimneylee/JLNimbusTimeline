//
//  AppDelegate.m
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-10-30.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "SMPublicTimlineListC.h"

@interface AppDelegate()
@end

@implementation AppDelegate

- (void)prepareForLaunching
{
    // Disk cache
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                        diskCapacity:20 * 1024 * 1024
                                                            diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    // AFNetworking
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:
//                                                       @"application/json",
//                                                       @"text/json",
//                                                       @"text/javascript",
//                                                       @"text/html",
//                                                       @"text/plain", nil]];
}

- (void)appearanceChange
{
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    if (IOS_IS_AT_LEAST_7) {
        // do change if u need
        //[[UINavigationBar appearance] setBarTintColor:[UIColor lightGrayColor]];
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self prepareForLaunching];
    [self appearanceChange];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController* c = [[SMPublicTimlineListC alloc] init];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:c];
    //navi.navigationBar.translucent = NO;
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
