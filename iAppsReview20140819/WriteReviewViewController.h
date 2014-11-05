//
//  WriteReviewViewController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 20/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+mmExtensions.h"
#import "mmStarRating.h"
#import "ReviewBusinessController.h"
#import "ReviewEntity.h"
#import "AppCategoryEntity.h"
#import "AppCategoryViewController.h"

@interface WriteReviewViewController : UITableViewController
    <UIImagePickerControllerDelegate,
     UINavigationControllerDelegate,
     UITextViewDelegate,
     AppCategoryDelegate>

- (IBAction)shareReview:(id)sender;
- (IBAction)accessPhotoLibrary:(id)sender;
- (IBAction)appNameChanged:(id)sender;
- (IBAction)postReview:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShare;
@property (weak, nonatomic) IBOutlet UITextView *tvwReview;
@property (weak, nonatomic) IBOutlet UIImageView *imgThumbNail;
@property (weak, nonatomic) IBOutlet UITextField *txtAppName;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
@property (weak, nonatomic) IBOutlet mmStarRating *starRating;
@property (weak, nonatomic) IBOutlet UITableViewCell *appCategoryCell;

@end
