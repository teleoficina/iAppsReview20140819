//
//  ReviewEntity.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReviewEntity : NSManagedObject

@property (nonatomic, retain) NSString * appName;
@property (nonatomic) int32_t userID;
@property (nonatomic) int32_t categoryID;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSString * image;
@property (nonatomic) BOOL isPosted;
@property (nonatomic) int16_t rating;


@end
