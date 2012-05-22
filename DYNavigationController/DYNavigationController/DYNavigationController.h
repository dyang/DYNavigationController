//
//  DYNavigationController.h
//  DYNavigationController
//
//  Created by Derek Yang on 05/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@protocol DYNavigationControllerDelegate;

@interface DYNavigationController : UIViewController

- (id)initWithRootViewController:(UIViewController <DYNavigationControllerDelegate>*)rootViewController;
- (void)pushViewController:(UIViewController <DYNavigationControllerDelegate> *)viewController;
- (void)popViewController;

@end

@protocol DYNavigationControllerDelegate <NSObject>

@property(nonatomic, assign) DYNavigationController *navigator;

@end
