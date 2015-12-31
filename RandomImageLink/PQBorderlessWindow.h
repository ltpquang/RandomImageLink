//
//  PQBorderlessWindow.h
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/20/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PQBorderlessWindow : NSWindow
- (void)fadeOutAndCloseWithDuration:(CFTimeInterval)duration;
@end
