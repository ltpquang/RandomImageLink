//
//  PQBorderlessWindow.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/20/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQBorderlessWindow.h"

@implementation PQBorderlessWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    if (self = [super initWithContentRect:contentRect
                                styleMask:NSBorderlessWindowMask
                                  backing:NSBackingStoreBuffered
                                    defer:flag]) {
        [self setAlphaValue:0.75];
        [self setOpaque:NO];
        [self setExcludedFromWindowsMenu:NO];
        [self setBackgroundColor:[NSColor clearColor]];
    }
    return self;
}

- (void)fadeOutAndCloseWithDuration:(CFTimeInterval)duration {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [[NSAnimationContext currentContext] setDuration:duration];
        [[self animator] setAlphaValue:0.0f];
    }
                        completionHandler:^{
                            [self close];
                        }];
}

@end
