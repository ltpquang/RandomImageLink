//
//  PQImageCategory.h
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/24/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PFObject;

@interface PQImageCategory : NSObject
@property NSString *name;
@property NSString *tag;
@property NSArray *imageArray;
- (id)initWithName:(NSString *)name andTag:(NSString *)tag andImages:(NSArray *)images;
- (id)initWithPFObject:(PFObject *)object;
@end
