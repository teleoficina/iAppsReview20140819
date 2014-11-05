//
//  ABusinessObject.m
//  iAppsReview
//
//  Created by Kevin McNeish on 5/21/14.
//  Copyright (c) 2014 Oak Leaf Enterprises, Inc. All rights reserved.
//

#import "ABusinessObject.h"

@implementation ABusinessObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dbName = @"iAppsReview20140819";
        self.copyDatabaseIfNotPresent=YES;
    }
    return self;
}

@end
