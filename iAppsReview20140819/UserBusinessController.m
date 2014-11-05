//
//  UserBusinessController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "UserBusinessController.h"

@implementation UserBusinessController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.entityClassName = @"UserEntity";
    }
    return self;
}

-(UserEntity *) getUser {
    NSMutableArray *userList = [self getAllEntities];
    
    if (userList.count > 0) {
        return userList[0];
    } else {
        return nil;
    }
}

@end
