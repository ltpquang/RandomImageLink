//
//  PQImageCategory.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/24/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQImageCategory.h"
#import "PQImage.h"
#import <ParseOSX/ParseOSX.h>

@implementation PQImageCategory
- (id)initWithName:(NSString *)name andTag:(NSString *)tag andImages:(NSArray *)images {
    if (self = [super init]) {
        _name = name;
        _tag = tag;
        _imageArray = images;
    }
    return self;
}


- (id)initWithPFObject:(PFObject *)object {
    if (self = [super init]) {
        _name = object[@"name"];
        _tag = object[@"tag"];
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        NSArray *pImages = object[@"imageArray"];
        for (PFObject *pImage in pImages) {
            [imageArray addObject:[[PQImage alloc] initWithPFObject:pImage]];
        }
        _imageArray = imageArray;
    }
    return self;
}
@end
