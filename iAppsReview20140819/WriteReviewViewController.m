//
//  WriteReviewViewController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 20/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "WriteReviewViewController.h"

@interface WriteReviewViewController ()



@end

@implementation WriteReviewViewController
{
    UIImage *image;
    NSURL *imageURL;
    ReviewBusinessController *reviewBC;
    NSUInteger appCategoryID;
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
    // self.starRating.delegate = self;
    
    reviewBC = [[ReviewBusinessController alloc] init];
    
    // Do any additional setup after loading the view.
}

// JSO
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AppCategorySegue"]) {
        
        // Get the destination controller
        AppCategoryViewController *controller = segue.destinationViewController;
        
        // Store the AppCategoryEntity on the destination controller
        // es la property que hemos definido en la view controller de destino
        controller.appCategoryID = appCategoryID;
        
        // Store a reference to this view controller in the
        // delegate property of the destination view controller
        controller.delegate = self;
    }
}

// JSO implantar protocolo para recargar la categoría seleccionada
-(void)updateAppCategory:(AppCategoryEntity *)appCategoryEntity {
    appCategoryID = appCategoryEntity.categoryID;
    self.appCategoryCell.detailTextLabel.text = appCategoryEntity.name;
    [self.tableView reloadData];
    
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

- (IBAction)shareReview:(id)sender {
    NSString *reviewText = self.tvwReview.text;
    NSArray *activityItems = [NSArray arrayWithObjects:reviewText, nil];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
}

- (IBAction)accessPhotoLibrary:(id)sender {
    
    // Create the image picker controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set the image picker controller properties
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Store a reference to the view controller in the delegate property
    imagePicker.delegate = self;
    
    // Display the image picker controller
    [self presentViewController:imagePicker animated:YES completion:nil];
}



-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Get the image and store it in the image view
    image = info[UIImagePickerControllerOriginalImage];
    self.imgThumbNail.image = image;
    
    // Get the URL of the image
    imageURL = info[UIImagePickerControllerReferenceURL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(BOOL)isReadyToShare {
    // Check if either the text view or the text field is empty
    if (self.tvwReview.text.length == 0 ||
        self.txtAppName.text.length == 0 ||
        self.starRating.rating == 0 ||
        appCategoryID == 0) {
          return NO;
    }
    else {
        return YES;
    }
}

- (void)enableDisableControls {
    self.btnShare.enabled = [self isReadyToShare];
    self.btnPost.enabled = [self isReadyToShare];
}

- (IBAction)appNameChanged:(id)sender {    
    [self enableDisableControls];
}


- (IBAction)postReview:(id)sender {
    ReviewEntity *reviewEntity = (ReviewEntity *)[reviewBC createEntity];
    reviewEntity.categoryID = appCategoryID; //ya no está harcoded...
    reviewEntity.userID = 1;
    reviewEntity.isPosted = NO;
    reviewEntity.rating = self.starRating.rating;
    reviewEntity.appName = self.txtAppName.text;
    reviewEntity.comments = self.tvwReview.text;
    reviewEntity.image = [imageURL absoluteString];
    
    // Save the ReviewEntity
    [reviewBC saveEntities];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)textViewDidChange:(UITextView *)textView {
    [self enableDisableControls];
}

-(void)starRating:(mmStarRating *)starRating ratingDidChange:(float)rating {
    [self enableDisableControls];
}




@end
