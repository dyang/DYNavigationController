//
//  DetailViewController.m
//  DYNavigationController
//
//  Created by Derek Yang on 05/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize navigator = _navigator;

- (id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
