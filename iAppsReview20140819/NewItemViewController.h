//
//  NewItemViewController.h
//  iAppsReview20140819
//
//  Created by jordi sanchez on 23/09/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <UIKit/UIKit.h>

// JSO
@class NewItemViewController;

@protocol NewItemDelegate <NSObject>
// Passes new item, nil if user cancels

-(void)newItemViewController:(NewItemViewController *)viewController didAddItem:(NSString *)item;
@end


@interface NewItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNewItem;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

// JSO property pa el protocolo delegate...
@property (weak, nonatomic) id <NewItemDelegate> delegate;

@end
