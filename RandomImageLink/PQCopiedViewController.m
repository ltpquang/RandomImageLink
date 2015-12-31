//
//  PQCopiedViewController.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/20/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQCopiedViewController.h"
#import "PQBorderlessWindow.h"

@interface PQCopiedViewController ()
@property (weak) IBOutlet NSTextField *messageTextField;
@property (nonatomic) NSString *messageText;
@end

@implementation PQCopiedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)viewDidAppear {
    PQBorderlessWindow *wd = (PQBorderlessWindow *)[[self view] window];
    [wd setLevel:NSStatusWindowLevel];
    [self performSelector:@selector(fadeOutWindow:) withObject:wd afterDelay:1.0f];
    
}

- (void)setString:(NSString *)text {
    _messageTextField.stringValue = text;
}

- (void)fadeOutWindow:(PQBorderlessWindow *)wd {
    [wd fadeOutAndCloseWithDuration:0.5f];
}

@end
