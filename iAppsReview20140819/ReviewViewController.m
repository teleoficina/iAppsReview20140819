//
//  ReviewViewController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 25/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController
{
AppCategoryBusinessController *appCategoryBC;
NSMutableArray *appCategoryList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //JSO
    appCategoryBC = [[AppCategoryBusinessController alloc] init];
    appCategoryList = [appCategoryBC getAllEntities];
    
    self.txtAppName.text = self.reviewEntity.appName;
    //self.txtAppCategory.text = [_reviewBC getCategoryName:1];
    
    // self.txtAppCategory.text = [appCategoryBC getCategoryNamebyID:5 matchingPredicate:nil];
     self.txtAppCategory.text = [appCategoryBC getCategoryName:self.reviewEntity.categoryID];
    
    self.starRating.rating = self.reviewEntity.rating;
    self.txtReview.text = self.reviewEntity.comments;
    self.txtAddresLabel.text = self.reviewEntity.addressLabelGPS;
    
    // JSO Get the image from the photo library and display it in the image view
    if (self.reviewEntity.image) {
        
        NSURL *imageURL = [NSURL URLWithString:self.reviewEntity.image];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library assetForURL:imageURL
                resultBlock:^(ALAsset *asset) {
                     self.imgThumbNail.image =
                     [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"error: %@", error);
                }];
    }
   
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
