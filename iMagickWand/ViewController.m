//
//  ViewController.m
//  iMagickWand
//
//  Created by Arthur Evstifeev on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    imageView.mwDelegate = self;
    imageView.color = [UIColor greenColor];
    imageView.tolerance = 20;
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [imageView release];
    imageView = nil;
    [_spinner release];
    _spinner = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [imageView release];
    [_spinner release];
    [super dealloc];
}

#pragma mark - MWImageViewDelegate

- (void)imageViewDidFinishedProcessing:(MWImageView *)imageView {
    [_spinner stopAnimating];
}

- (void)imageViewDidStartedProcessing:(MWImageView *)imageView {
    [_spinner startAnimating];
}

@end
