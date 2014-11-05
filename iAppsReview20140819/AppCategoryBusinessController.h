//
//  AppCategoryBusinessController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "ABusinessObject.h"
#import "AppCategoryEntity.h"

@interface AppCategoryBusinessController : ABusinessObject

// JSO la utilizaremos para añadir nuevas entidades
@property (nonatomic, retain) NSMutableArray *entityList;

@property (nonatomic) NSInteger *maxCategoryID;
@property (nonatomic) NSString *categoryName;

-(NSMutableArray *)getAllEntitiesByDisplayOrder;
- (void)addItemToList:(NSString *)item;

// JSO Método pa obtener el max de la categoryID de la bbdd
-(NSInteger *)getMaxValueOfCategoryID;

// JSO Método pa obtener el nombre de la categoría a partir de un ID
-(NSString *)getCategoryName:(NSInteger *)itemID;

// JSO vamos a eliminar la fila seleccionada de la lista
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

// JSO vamos a modificar el orden en la lista
- (void) moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end
