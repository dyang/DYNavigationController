//
//  AppDelegate.m
//  DYNavigationController
//
//  Created by Derek Yang on 05/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "DYNavigationController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    // Override point for customization after application launch.
    RootViewController *rootViewController = [[[RootViewController alloc] init] autorelease];
    DYNavigationController *navigationController = [[[DYNavigationController alloc]
            initWithRootViewController:rootViewController] autorelease];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end