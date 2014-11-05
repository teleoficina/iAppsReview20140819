//
//  ReviewBusinessController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "ReviewBusinessController.h"

@implementation ReviewBusinessController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.entityClassName = @"ReviewEntity";
    }
    return self;
}

// JSO Método pa obtener el nombre de la categoría a partir de un ID
-(NSString *)getCategoryName:(NSInteger *)itemID
{
    NSString *categoryName;
    categoryName = @"hola campeón";
    return categoryName;
}


// JSO para reordenar ítems dentro de una lista utilizada en la tabla de la escena
- (void) moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    /*
	int from = sourceIndexPath.row;
	int to = destinationIndexPath.row;
	
	if (from == to) {
		return;
	}
    
	// Get the entity to be reordered, remove it from
	// its old position and add it in its new position
	ReviewEntity *reviewEntity = self.entityList[from];
	[self.entityList removeObjectAtIndex:from];
	[self.entityList insertObject:reviewEntity atIndex:to];
    
	// Set the new order of the object
	double lower, upper = 0.0;
	
	// Check for an item before it
	if (to > 0) {
		lower = [self.entityList[to - 1] categoryID] ;
	}
	else{
		lower = [self.entityList[1] categoryID] - 2.0;
	}
    
	// Check for an item after it
	if (to < self.entityList.count - 1) {
		upper = [self.entityList[to + 1] categoryID];
	}
	else {
		upper = [self.entityList[to - 1] categoryID] + 2.0;
	}
    
	// Add the upper and lower, divide by two
	// to derive the new order
	double newOrder = (lower + upper) / 2.0;
	reviewEntity.displayOrder = newOrder;
     */
}

@end
