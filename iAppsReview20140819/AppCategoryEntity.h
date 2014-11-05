//
//  AppCategoryEntity.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppCategoryEntity : NSManagedObject

@property (nonatomic) int32_t categoryID;
@property (nonatomic, retain) NSString * name;



@end
