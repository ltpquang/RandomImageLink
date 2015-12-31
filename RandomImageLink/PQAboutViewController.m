//
//  PQAboutViewController.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/20/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQAboutViewController.h"

@interface PQAboutViewController ()
@property (weak) IBOutlet NSButton *okayButton;

@end

@implementation PQAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSMutableAttributedString *attrTitle =
    [[NSMutableAttributedString alloc] initWithString:@":okay:"];
    NSUInteger len = [attrTitle length];
    NSRange range = NSMakeRange(0, len);
    [attrTitle addAttribute:NSForegroundColorAttributeName value:[NSColor colorWithCalibratedRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0] range:range];
    [attrTitle setAlignment:NSCenterTextAlignment range:range];
    [attrTitle fixAttributesInRange:range];
    

    
    [_okayButton setAttributedTitle:attrTitle];
}
- (IBAction)okayButtonClicked:(id)sender {
    [[[self view] window] close];
}

@end
