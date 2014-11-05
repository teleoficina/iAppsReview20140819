//
//  SettingsViewController.h
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 25/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "UserBusinessController.h"


@interface SettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEMail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btnFeedback;
@property (strong, nonatomic) UserBusinessController *userBC;

- (IBAction)emailReturnKey:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)editToggle:(id)sender;

- (IBAction)setDoneEnabledValue:(id)sender;
@end
