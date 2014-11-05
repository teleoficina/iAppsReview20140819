//
//  MyReviewViewController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 25/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "MyReviewViewController.h"


@interface MyReviewViewController ()

@end

@implementation MyReviewViewController {
    ReviewBusinessController *reviewBC;
    NSMutableArray *reviewList;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //JSO
    reviewBC = [[ReviewBusinessController alloc] init];
    reviewList = [reviewBC getAllEntities];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // JSO Habilitamos el botón "Edit" en la escena
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return reviewList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AppNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier         forIndexPath:indexPath];
    
    // Configure the cell...
    ReviewEntity *reviewEntity = [reviewList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = reviewEntity.appName;
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ReviewSegue" sender:nil];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ReviewSegue"]) {
        // Paso 1: obtener la VCd
        ReviewViewController *reviewVC = segue.destinationViewController;
        
        // Paso 2: Obtener el ítem actual
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Paso 3: Salvar el entity actual
        reviewVC.reviewEntity = [reviewList objectAtIndex:indexPath.row];
        
        // Paso 4: Salvar el BC actual
        reviewVC.reviewBC = reviewBC;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


// JSO Para permitir la reordenación de los elementos de la tabla, en modo edición
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    
    
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end
