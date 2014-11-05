//
//  NewItemViewController.m
//  iAppsReview20140819
//
//  Created by jordi sanchez on 23/09/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "NewItemViewController.h"

@interface NewItemViewController ()

@end

@implementation NewItemViewController

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
    
    [self.txtNewItem becomeFirstResponder];
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

#pragma mark - Action Methods

- (IBAction)cancel:(id)sender {
    [self.delegate newItemViewController:self didAddItem:nil];
}

- (IBAction)done:(id)sender {
    [self.delegate newItemViewController:self didAddItem:self.txtNewItem.text];
}

@end
