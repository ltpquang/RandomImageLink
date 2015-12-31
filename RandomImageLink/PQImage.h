//
//  PQImage.h
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/24/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PFObject;

@interface PQImage : NSObject
@property NSString *imageName;
@property NSString *imageUrl;

- (id)initWithName:(NSString *)name andUrl:(NSString *)url;
- (id)initWithPFObject:(PFObject *)object;

@end
