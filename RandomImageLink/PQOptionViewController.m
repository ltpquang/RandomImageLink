//
//  PQOptionViewController.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/20/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQOptionViewController.h"

@interface PQOptionViewController ()

@end

@implementation PQOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)cancelButtonTUI:(id)sender {
    //[self dismissController:self];
    [[[self view] window] close];
    NSLog(@"Cancel");
}

@end
