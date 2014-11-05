//
//  UserBusinessController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "ABusinessObject.h"
#import "UserEntity.h"

@interface UserBusinessController : ABusinessObject

// Get the user entity object
-(UserEntity *) getUser;

@end
