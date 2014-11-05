//
//  ReviewBusinessController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "ABusinessObject.h"
#import "ReviewEntity.h"

@interface ReviewBusinessController : ABusinessObject

@property (nonatomic, retain) NSMutableArray *entityList;

// JSO Método pa obtener el nombre de la categoría a partir de un ID
-(NSString *)getCategoryName:(NSInteger *)itemID;

// JSO para reordenar ítems dentro de una lista utilizada en la tabla de la escena
- (void) moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end
