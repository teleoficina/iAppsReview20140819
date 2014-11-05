//
//  UIViewController+mmExtensions.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 20/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "UIViewController+mmExtensions.h"

@implementation UIViewController (mmExtensions)

- (IBAction)backgroundTouched:(id)sender
{
	[self.view endEditing:YES];
}

// An Action method that hides the keyboard when the user touches the keyboard Return
// You can link a UITextField's "Did End on Exit" event to this method
-(IBAction)textFieldReturn:(id)sender
{
	[sender resignFirstResponder];
}

@end
