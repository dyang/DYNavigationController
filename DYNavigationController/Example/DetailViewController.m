/*
Copyright (C) 2012 Derek Yang (http://www.iappexperience.com). All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
* Neither the name of the author nor the names of its contributors may be used
  to endorse or promote products derived from this software without specific
  prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];

    UILabel *popInstruction = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    popInstruction.backgroundColor = [UIColor clearColor];
    popInstruction.text = @"Swipe right to pop current view out";
    popInstruction.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:popInstruction];
    [popInstruction release];

    UILabel *pushInstruction = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 300, 40)];
    pushInstruction.backgroundColor = [UIColor clearColor];
    pushInstruction.text = @"Swipe left to push a new view in";
    pushInstruction.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:pushInstruction];
    [pushInstruction release];
}

#pragma mark - DYNavigationControllerDelegate

- (UIViewController *)viewControllerToPush {
    UIViewController *anotherDetailViewController = [[UIViewController alloc] init];
    anotherDetailViewController.view.backgroundColor = [UIColor lightGrayColor];
    return [anotherDetailViewController autorelease];
}

@end
