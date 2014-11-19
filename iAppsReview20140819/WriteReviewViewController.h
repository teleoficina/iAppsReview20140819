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

//branch-001 añadir el framework de localización y métodos delegate "CLLocationManagerDelegate"
#import <CoreLocation/CoreLocation.h>
//end branch-001

@interface WriteReviewViewController : UITableViewController
    <UIImagePickerControllerDelegate,
     UINavigationControllerDelegate,
     UITextViewDelegate,
     CLLocationManagerDelegate,
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

//branch-001 20141113
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)getAddressButton:(id)sender;

//branch-001 20141119
@property (weak, nonatomic) NSString *myAddress;
@property (weak, nonatomic) NSString *myLatitude;
@property (weak, nonatomic) NSString *myLongitude;

@property (nonatomic, assign) BOOL hapetao;
//end branch-001

@end
