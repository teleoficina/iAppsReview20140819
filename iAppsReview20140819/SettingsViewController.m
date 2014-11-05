//
//  SettingsViewController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 25/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController {
    // declaremos las variables de instancia...
    UserEntity *userEntity;
    BOOL isEditMode;
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
    // Do any additional setup after loading the view.
    
    // JSO recuperamos el primer usuario para preinformar la escena...
    self.userBC = [[UserBusinessController alloc] init];
    userEntity = [self.userBC getUser];
    self.txtEMail.text = userEntity.email;
    self.txtPassword.text = userEntity.password;
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

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

// JSO para cancelar el modo edición
-(void)cancelEditMode
{
    // Change the title of the button to Edit and enable
    self.navigationItem.rightBarButtonItem.title = @"Edit";
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    // Hide the Cancel button, display standard back button
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = NO;
    
    // Enable the buttons
    self.btnSignUp.enabled = YES;
    self.btnFeedback.enabled = YES;
    
    // Disable user interaction in text fields
    self.txtEMail.userInteractionEnabled = NO;
    self.txtPassword.userInteractionEnabled = NO;
    
    isEditMode = NO;
}

// JSO controlaremos habilitar los campos de la escena
- (IBAction)editToggle:(id)sender {
    
    if (isEditMode) {
        // Done !
        if (!userEntity) {
            userEntity = (UserEntity *)[self.userBC createEntity];
        }
        userEntity.email = self.txtEMail.text;
        userEntity.password = self.txtPassword.text;
        
        // temp values
        userEntity.userID = 1;
        userEntity.firstName = @"Jordito";
        userEntity.lastName = @"Sanxes";
        
        // Save the changes
        [self.userBC saveEntities];
        
        // Enable the login button
        self.btnLogin.enabled = YES;
        
        // Cancel the edit mode
        [self cancelEditMode];
        
    } else {
        // change the tile of the button to Done
        //self.navigationItem.rightBarButtonItem.title = @"Done";
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Done", @"Finished adding a record");
        
        // Enable or Disable "Done" button
        [self setDoneEnabledValue:nil];
        
        // Hide the standard back button, display a cancel button
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] /*initWithTitle:@"Cancel" */
            initWithTitle:NSLocalizedString(@"Cancel", @"Cancel adding a recor")
            style:UIBarButtonItemStylePlain
            target:self
            action:@selector(cancel)];
        
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
        
        // Disable the buttons
        self.btnLogin.enabled = NO;
        self.btnSignUp.enabled = NO;
        self.btnFeedback.enabled = NO;
        
        // Enable user interaction in the text fields
        self.txtEMail.userInteractionEnabled = YES;
        self.txtPassword.userInteractionEnabled = YES;
        
        // Set focus to the email text field
        [self.txtEMail becomeFirstResponder];
        
        isEditMode = YES;
    }
}

- (IBAction)setDoneEnabledValue:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = [self isLoginReady];
}


- (IBAction)emailReturnKey:(id)sender {
    [self.txtPassword becomeFirstResponder];
}

-(BOOL)isLoginReady {
    return self.txtEMail.text.length > 0 && self.txtPassword.text.length > 0;
}

// JSO
-(void)cancel {
    self.txtEMail.text = userEntity.email;
    self.txtPassword.text = userEntity.password;
    [self cancelEditMode];
}


@end
