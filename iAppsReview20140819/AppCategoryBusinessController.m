//
//  AppCategoryBusinessController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "AppCategoryBusinessController.h"


@implementation AppCategoryBusinessController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.entityClassName = @"AppCategoryEntity";
    }
    return self;
}

// JSO inicializa con una lista ordenada, ordenado por la columna "name" de la tabla
// el puntero de la lista devuelta será utilizada por "appCategoryList" de su objeto respectiv
-(NSMutableArray *)getAllEntitiesByDisplayOrder
{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:
                                        @"name" ascending:YES];
    
	self.entityList = [self getEntitiesSortedBy:sortDescriptor matchingPredicate:nil];
    //self.entityList = [self getTheMaxOfEntitiesSortedBy:sortDescriptor matchingPredicate:nil];
	return self.entityList;
}


// JSO añadir la nueva categoría a la lista presentada en pantalla
- (void)addItemToList:(NSString *)item
{
	AppCategoryEntity *appCategoryEntity = (AppCategoryEntity *)[self createEntity];
    appCategoryEntity.name = item;
    
    // JSO método para obtener el valor del campo categoryID
    appCategoryEntity.categoryID = (int)self.getMaxValueOfCategoryID + 1;
	
	[self.entityList addObject:appCategoryEntity];
}

// JSO obtener el máximo valor de la columna categoryID de la bbdd
-(NSInteger *)getMaxValueOfCategoryID
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:
                                        @"name" ascending:YES];
    
	self.maxCategoryID = [self getTheMaxValueOfEntitiesSortedBy:sortDescriptor matchingPredicate:nil];
    return self.maxCategoryID;
}

// JSO Método pa obtener el nombre de la categoría a partir de un ID
-(NSString *)getCategoryName:(NSInteger *)itemID
{
    self.categoryName  = [self getCategoryNamebyID:itemID matchingPredicate:nil];
    //self.categoryName = @"hola campeón";
    return self.categoryName;
    
}


// JSO vamos a eliminar la fila seleccionada de la lista
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath
{
	[self.entityList removeObjectAtIndex:indexPath.row];
}


// JSO vamos a modificar el orden en la lista
- (void) moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	int from = sourceIndexPath.row;
	int to = destinationIndexPath.row;
	// Set the new order of the object
	double lower, upper = 0.0;
    
	if (from == to) {
		return;
	}
    
	// Get the entity to be reordered, remove it from
	// its old position and add it in its new position
	AppCategoryEntity *appCategoryEntity = self.entityList[from];
	[self.entityList removeObjectAtIndex:from];
	[self.entityList insertObject:appCategoryEntity atIndex:to];
    
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
	appCategoryEntity.categoryID = newOrder;
}

@end
