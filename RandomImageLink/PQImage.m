//
//  PQImage.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/24/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//

#import "PQImage.h"
#import <ParseOSX/ParseOSX.h>

@implementation PQImage
- (id)initWithName:(NSString *)name andUrl:(NSString *)url {
    if (self = [super init]) {
        _imageName = name;
        _imageUrl = url;
    }
    return self;
}

- (id)initWithPFObject:(PFObject *)object {
    if (self = [super init]) {
        PFFile *imageFile = object[@"imageFile"];
        
        _imageName = object[@"imageName"];
        _imageUrl = imageFile.url;
    }
    return self;
}
@end
