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

- (UIViewController *)currentViewController;
- (UIViewController *)previousViewController;
- (void)setNavigatorIfNeeded:(UIViewController *)viewController;
- (void)setUpGestureRecognizers:(UIViewController *)viewController;
- (void)tearDownGestureRecognizers:(UIViewController *)viewController;
- (void)popCurrentViewOut:(UIGestureRecognizer *)gestureRecognizer;
- (void)pushNewViewIn:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation DYNavigationController

@synthesize viewControllerStack = _viewControllerStack;

#pragma mark - Public interface

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if ((self = [super init])) {
        self.viewControllerStack = [NSMutableArray arrayWithObject:rootViewController];

        // Connect DYNavigationController to RootViewController if needed
        [self setNavigatorIfNeeded:rootViewController];

        // Add the root view into current view hierarchy
        [self.view addSubview:rootViewController.view];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController {
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
            // Connect DYNavigationController to viewController if needed
            [self setNavigatorIfNeeded:viewController];

            // Set up gesture recognizer so that we can respond to swipes
            [self setUpGestureRecognizers:viewController];

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
            // Tear down gesture recognizers
            [self tearDownGestureRecognizers:[self currentViewController]];

            // Remove current view controller from viewControllerStack
            [self.viewControllerStack removeLastObject];
        }
    }];
}

#pragma mark - Private implementation

- (void)setNavigatorIfNeeded:(UIViewController *)viewController {
    if ([viewController respondsToSelector:@selector(setNavigator:)]) {
        [viewController performSelector:@selector(setNavigator:) withObject:self];
    }
}

- (UIViewController<DYNavigationControllerDelegate> *)currentViewController {
    return [self.viewControllerStack lastObject];
}

- (UIViewController<DYNavigationControllerDelegate> *)previousViewController {
    return [self.viewControllerStack objectAtIndex:self.viewControllerStack.count - 2];
}

- (void)setUpGestureRecognizers:(UIViewController *)viewController {
    // Swipe right: pop the current view and go back one level
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewOut:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [viewController.view addGestureRecognizer:rightSwipeGesture];
    [rightSwipeGesture release];

    // Swipe left: push a new view
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pushNewViewIn:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [viewController.view addGestureRecognizer:leftSwipeGesture];
    [leftSwipeGesture release];
}

- (void)tearDownGestureRecognizers:(UIViewController *)viewController {
    for (UIGestureRecognizer *gestureRecognizer in [viewController.view gestureRecognizers]) {
        [viewController.view removeGestureRecognizer:gestureRecognizer];
    }
}

- (void)popCurrentViewOut:(UIGestureRecognizer *)gestureRecognizer {
    [self popViewController];
}

- (void)pushNewViewIn:(UIGestureRecognizer *)gestureRecognizer {
    // If current view controller responds to viewControllerToPush, then acquire that view controller
    // and push it to the view hierarchy.
    UIViewController *currentViewController = [self currentViewController];
    if ([currentViewController respondsToSelector:@selector(viewControllerToPush)]) {
        UIViewController *newViewController = [currentViewController performSelector:@selector(viewControllerToPush)];
        [self pushViewController:newViewController];
    }
}

- (void)dealloc {
    [_viewControllerStack release]; _viewControllerStack = nil;
    [super dealloc];
}

@end
