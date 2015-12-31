//
//  PQTransparentView.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/20/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQTransparentView.h"

@implementation PQTransparentView

- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:6.0 yRadius:6.0];
    [[NSColor blackColor] set];
    [path fill];
}

@end
