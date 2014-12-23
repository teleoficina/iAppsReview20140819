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
    
    //branch-001 20141119 objetos para gestionar el gps
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    //end branch-001
    // branch-002 21041211
    NSString *myLongitud;
    NSString *myLatitud;
    // end branch-002
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
    
    //branch-001 20141119 Inicializamos el gps
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


- (IBAction)shareReview:(id)sender {
    NSString *reviewText = self.tvwReview.text;
    NSArray *activityItems = [NSArray arrayWithObjects:reviewText, nil];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
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


// JSO Grabamos en la bbdd...
- (IBAction)postReview:(id)sender {
    ReviewEntity *reviewEntity = (ReviewEntity *)[reviewBC createEntity];
    reviewEntity.categoryID = appCategoryID; //ya no está harcoded...
    reviewEntity.userID = 1;
    reviewEntity.isPosted = NO;
    reviewEntity.rating = self.starRating.rating;
    reviewEntity.appName = self.txtAppName.text;
    reviewEntity.comments = self.tvwReview.text;
    reviewEntity.image = [imageURL absoluteString];
    // branch-001
    reviewEntity.addressLabelGPS = self.addressLabel.text;
    // branch-002
    reviewEntity.gpsLatitude = myLatitud;
    reviewEntity.gpsLongitude = myLongitud;
    
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


// branch-003
// Cuando se pulsa en la imagen "Add Image": Tomar foto o recuperarla del carrete
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

// branch-003
// Cuando se pulsa en el botón inferior seleccionar opción para hacer la foto
- (IBAction)seleccionarOpcionFoto:(id)sender {
    UIActionSheet *tomarFoto = [[UIActionSheet alloc]
                                initWithTitle:nil
                                delegate:self
                                cancelButtonTitle:@"Cancelar"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"Hacer Foto", @"Seleccionar foto existente", nil
                                ];
    tomarFoto.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [tomarFoto showInView:[UIApplication sharedApplication].keyWindow];
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
    
    // obtenemos las coordenadas...
    if (currentLocation != nil) {
        myLatitud = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        myLongitud = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];

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


#pragma Mark - UIActionSheetDelegate
// branch-003 método delegado tratamiento alternativas botón "take a fotu"
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        // Levantar cámara
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setModalPresentationStyle:UIModalPresentationCurrentContext];
        [imagePicker setDelegate:self];
        [imagePicker setAllowsEditing:YES];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else if (buttonIndex == 1) {
        // Levantar Librería
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        [imagePicker setAllowsEditing:YES];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


// -----------
#pragma mark - métodos delegate de UIImagePickerDelegate
// branch-003 gestionar el acceso al carrete o a la cámara
// ----- nuevo -------
/*
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imagenTomada = info[UIImagePickerControllerEditedImage];
    self.imgThumbNail.image = imagenTomada;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
*/
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// --- original ----

 -(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 
  
 // Get the image and store it in the image view
 //image = info[UIImagePickerControllerOriginalImage];
 image = info[UIImagePickerControllerEditedImage];

 // Branch-003-01 salvar imagen al carrete...
 UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
 self.imgThumbNail.image = image;
 
 // Get the URL of the image
 imageURL = info[UIImagePickerControllerReferenceURL];
     
 }


/*
 -(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 */

// --------------

@end
