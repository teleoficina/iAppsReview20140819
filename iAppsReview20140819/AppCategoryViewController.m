//
//  AppCategoryViewController.m
//  iAppsReview20140819
//
//  Created by Marc Gamarra Roman on 21/08/14.
//  Copyright (c) 2014 teleOficina Services. All rights reserved.
//

#import "AppCategoryViewController.h"

@interface AppCategoryViewController ()

@end

@implementation AppCategoryViewController
{
    AppCategoryBusinessController *appCategoryBC;
    NSMutableArray *appCategoryList;
    NSIndexPath *oldIndexPath;
    int max_category_id;
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
    
    appCategoryBC = [[AppCategoryBusinessController alloc] init];
    // appCategoryList = [appCategoryBC getAllEntities];
    appCategoryList = [appCategoryBC getAllEntitiesByDisplayOrder];
    
    // JSO para habilitar el botón de reordenar los elementos de la lista
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


// JSO
-(void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if(!editing) {
        [appCategoryBC saveEntities];
    }
}


// JSO implementación protocolo delegate para añadir una nueva categoría
-(void)newItemViewController:(NewItemViewController *)viewController didAddItem:(NSString *)item
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        if (item.length != 0) {
            // Add the new item to the appCategoryBusinessController list
            [appCategoryBC addItemToList:item];
            
            // JSO ahora salvamos la categoría a la bbdd
            [appCategoryBC saveEntities];
            
            // Insert item after the last row
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(appCategoryList.count -1) inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:
                            [NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Scroll to the new row
            [self.tableView scrollToRowAtIndexPath:indexPath
                            atScrollPosition:
                            UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

// JSO implementación protocolo delegate - segue (1)
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewItemSegue"]) {
        NewItemViewController *nvc = segue.destinationViewController;
        nvc.delegate = self;
    }
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
    return appCategoryList.count;
}


// JSO

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier
                             forIndexPath:indexPath];
    
    // Configure the cell...
    
    AppCategoryEntity *appCategoryEntity = [appCategoryList
                                            objectAtIndex:indexPath.row];
    
    cell.textLabel.text = appCategoryEntity.name;
    
    // Check/uncheck the current cell
    if (appCategoryEntity.categoryID == self.appCategoryID) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        oldIndexPath = indexPath;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [appCategoryBC deleteEntity:appCategoryList[indexPath.row]];
        [appCategoryList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


// JSO Para reorganizar la presentación de ítems en la tabla
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [appCategoryBC moveObjectAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

// JSO
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Deselect the currently selected row Quitamos el azulito de "seleccionado"
    [self.tableView deselectRowAtIndexPath:
     [self.tableView indexPathForSelectedRow] animated:NO];
    
    // Uncheck the previously selected cell, check the currently selected cell
    [tableView cellForRowAtIndexPath:oldIndexPath].accessoryType = UITableViewCellAccessoryNone;
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    // Save the current indexPath for later
    oldIndexPath = indexPath;
    
    // Send a callback message to the delegate (presentating view controller)
    AppCategoryEntity *categoryEntity = appCategoryList[indexPath.row];
    [self.delegate updateAppCategory:categoryEntity];
    
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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addItem:(id)sender {
    [self performSegueWithIdentifier:@"NewItemSegue" sender:self];
}

@end
