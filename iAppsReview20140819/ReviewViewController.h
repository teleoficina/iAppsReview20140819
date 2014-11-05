//
//  ReviewViewController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 25/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "mmStarRating.h"
#import "ReviewEntity.h"
#import "ReviewBusinessController.h"
#import "AppCategoryBusinessController.h"
#import "AppCategoryEntity.h"

@interface ReviewViewController : UIViewController

// heredado desde la anterior escena
@property (strong, nonatomic) ReviewEntity *reviewEntity;
@property (strong, nonatomic) ReviewBusinessController *reviewBC;

// Referencia a los campos de la escena
@property (weak, nonatomic) IBOutlet UILabel *txtAppName;
@property (weak, nonatomic) IBOutlet UILabel *txtAppCategory;
@property (weak, nonatomic) IBOutlet mmStarRating *starRating;
@property (weak, nonatomic) IBOutlet UIImageView *imgThumbNail;
@property (weak, nonatomic) IBOutlet UITextView *txtReview;

// para utilizarlos en la consulta de la tabla category

@end
