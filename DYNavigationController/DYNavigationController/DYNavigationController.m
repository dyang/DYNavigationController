//
//  DYNavigationController.m
//  DYNavigationController
//
//  Created by Derek Yang on 05/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DYNavigationController.h"

#define ANIMATION_DURATION 0.4
#define ANIMATION_DELAY 0

@interface DYNavigationController ()

@property(nonatomic, retain) UIViewController *rootViewController;
@property(nonatomic, retain) UIViewController <DYNavigationControllerDelegate> *currentViewController;
@property(nonatomic, retain) UIViewController <DYNavigationControllerDelegate> *previousViewController;

@end

@implementation DYNavigationController

@synthesize rootViewController = _rootViewController;
@synthesize currentViewController = _currentViewController;
@synthesize previousViewController = _previousViewController;

- (id)initWithRootViewController:(UIViewController<DYNavigationControllerDelegate> *)rootViewController {
    if ((self = [super init])) {
        self.rootViewController = rootViewController;
        self.currentViewController = rootViewController;

        // Connect DYNavigationController with RootViewController
        rootViewController.navigator = self;

        // Add the root view into current view hierarchy
        [self.view addSubview:rootViewController.view];
    }
    return self;
}

- (void)pushViewController:(UIViewController <DYNavigationControllerDelegate> *)viewController {
    // Connect DYNavigationController with viewController
    viewController.navigator = self;

    // Place the new view to the right next to the current view
    viewController.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);

    // Add the new view to our view hierarchy so that it displays on screen.
    [self.view addSubview:viewController.view];

    // Start animation
    [UIView animateWithDuration:ANIMATION_DURATION delay:ANIMATION_DELAY options:UIViewAnimationCurveEaseInOut animations:^{
        viewController.view.frame = self.view.bounds;
        self.currentViewController.view.frame = CGRectOffset(self.view.bounds, -self.view.bounds.size.width, 0);
    }   completion:^(BOOL finished) {
        if (finished) {
            // Update references so that we can use them later on.
            self.previousViewController = self.currentViewController;
            self.currentViewController = viewController;
        }
    }];
}

- (void)dealloc {
    [_rootViewController release]; _rootViewController = nil;
    [_currentViewController release]; _currentViewController = nil;
    [_previousViewController release]; _previousViewController = nil;
    [super dealloc];
}

@end
