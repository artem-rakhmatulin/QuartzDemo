//
//  AppDelegate.m
//  QuartzDemo
//
//  Created by Artem Rakhmatulin on 04/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    UIWindow *_window;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:[[QDViewController alloc] init]];
    [_window makeKeyAndVisible];
    
    return YES;
} //aplication:didFinishLaunchingWithOptions:

- (UIWindow *)window
{
    return _window;
} //window

@end
