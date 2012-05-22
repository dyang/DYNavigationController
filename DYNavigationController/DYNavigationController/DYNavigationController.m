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

@property(nonatomic, retain) NSMutableArray *viewControllerStack;
@property(nonatomic, retain) UISwipeGestureRecognizer *gesture;

- (UIViewController <DYNavigationControllerDelegate> *)currentViewController;
- (UIViewController <DYNavigationControllerDelegate> *)previousViewController;
- (void)popCurrentViewOut:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation DYNavigationController

@synthesize viewControllerStack = _viewControllerStack;
@synthesize gesture = _gesture;

#pragma mark - Public interface

- (id)initWithRootViewController:(UIViewController<DYNavigationControllerDelegate> *)rootViewController {
    if ((self = [super init])) {
        self.viewControllerStack = [NSMutableArray arrayWithObject:rootViewController];

        // Connect DYNavigationController to RootViewController
        rootViewController.navigator = self;

        // Add the root view into current view hierarchy
        [self.view addSubview:rootViewController.view];

        self.gesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewOut:)] autorelease];
       self.gesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return self;
}

- (void)pushViewController:(UIViewController <DYNavigationControllerDelegate> *)viewController {
    // Place the new view to the right next to the current view
    viewController.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);

    // Add the new view to our view hierarchy so that it displays on screen.
    [self.view addSubview:viewController.view];

    // Start animation
    [UIView animateWithDuration:ANIMATION_DURATION delay:ANIMATION_DELAY options:UIViewAnimationCurveEaseInOut animations:^{
        [self currentViewController].view.frame = CGRectOffset(self.view.bounds, -self.view.bounds.size.width, 0);
        viewController.view.frame = self.view.bounds;
    }   completion:^(BOOL finished) {
        if (finished) {
            // Connect DYNavigationController to viewController
            viewController.navigator = self;

            // Set up gesture recognizer so that we can respond to swipes
            [viewController.view addGestureRecognizer:self.gesture];

            // Add the new controller to our viewControllerStack
            [self.viewControllerStack addObject:viewController];
        }
    }];
}

- (void)popViewController {
    // Sanity check - We only pop when there are at least two viewControllers in the stack,
    // otherwise there is nothing to pop
    if (self.viewControllerStack.count < 2) return;

    // Start animation
    [UIView animateWithDuration:ANIMATION_DURATION delay:ANIMATION_DELAY options:UIViewAnimationCurveEaseInOut animations:^{
        [self currentViewController].view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
        [self previousViewController].view.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        if (finished) {
            // Tear down gesture recognizer
            [[self currentViewController].view removeGestureRecognizer:self.gesture];

            // Remove current view controller from viewControllerStack
            [self.viewControllerStack removeLastObject];
        }
    }];
}

#pragma mark - Private implementation

- (UIViewController<DYNavigationControllerDelegate> *)currentViewController {
    return [self.viewControllerStack lastObject];
}

- (UIViewController<DYNavigationControllerDelegate> *)previousViewController {
    return [self.viewControllerStack objectAtIndex:self.viewControllerStack.count - 2];
}

- (void)popCurrentViewOut:(UIGestureRecognizer *)gestureRecognizer {
    [self popViewController];
}

- (void)dealloc {
    [_viewControllerStack release]; _viewControllerStack = nil;
    [_gesture release]; _gesture = nil;
    [super dealloc];
}

@end
