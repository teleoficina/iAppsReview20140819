//
//  AppCategoryViewController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCategoryBusinessController.h"
#import "AppCategoryEntity.h"
#import "NewItemViewController.h"

// JSO
@protocol AppCategoryDelegate <NSObject>

// este método se debera implantar en las VC de origen para que este VC pueda devolver un objeto AppCategoryEntity a la escena origen
-(void)updateAppCategory:(AppCategoryEntity *)appCategoryEntity;

@end


@interface AppCategoryViewController : UITableViewController <NewItemDelegate>


- (IBAction)addItem:(id)sender;

// esta propiedad viene heredando el valor de la anteiror escena
@property (assign, nonatomic) NSUInteger appCategoryID;

// esta propiedad apuntará a la VC de origen
@property (nonatomic, weak) id <AppCategoryDelegate> delegate;




@end
