//
//  DYNavigationController.m
//  DYNavigationController
//
//  Created by Derek Yang on 05/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DYNavigationController.h"

@interface DYNavigationController ()

@property(nonatomic, retain) UIViewController *rootViewController;

@end

@implementation DYNavigationController

@synthesize rootViewController = _rootViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if ((self = [super init])) {
        self.rootViewController = rootViewController;
        self.view = rootViewController.view;
    }
    return self;
}

- (void)dealloc {
    [_rootViewController release]; _rootViewController = nil;
    [super dealloc];
}

@end
