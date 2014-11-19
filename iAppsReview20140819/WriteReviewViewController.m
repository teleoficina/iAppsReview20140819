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
    
    //branch-001 20141119
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    //end branch-001
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
    
    //branch-001 20141119
    manager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    //end branch-001
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



// branch-001 20141119
- (IBAction)getAddressButton:(id)sender {
    self.addressLabel.text = @"Pero qué hases \ndesgraciao !!";
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // obtener ubicación GPS
    NSLog(@"Inicializando captura gps...");
    [manager startUpdatingLocation];
}


#pragma mark CLLocationManagerDelegate Methods
// branch-001 20141119
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self setHapetao:TRUE];
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location! : (");
    [manager stopUpdatingLocation];
}


// branch-001 20141119
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSError *habrapetao = [[NSError alloc]init];
    NSMutableDictionary *detallesHabraPetao = [[NSMutableDictionary alloc] init];
    
    NSLog(@"Location: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        [self setMyAddress:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]];
        [self setMyLongitude:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]];
        
    }
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            
            placemark = [placemarks lastObject];
            
            [self setMyAddress: [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@ %@\n",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country]];
            [self setHapetao:false];
            self.addressLabel.text = [self myAddress];
            
        } else {
            NSLog(@"Error debugDescription: %@", error.debugDescription);
            [detallesHabraPetao setValue:@"nohaygps" forKey:NSLocalizedDescriptionKey];
            [self setHapetao:true];
        }
    }
     ];
    
    [manager stopUpdatingLocation];
    
    habrapetao = [NSError errorWithDomain:@"nohaygps" code:200 userInfo:@{NSLocalizedDescriptionKey:@"Something went wrong"}];
    
}

@end
