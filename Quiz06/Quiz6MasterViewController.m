//
//  Quiz6MasterViewController.m
//  Quiz6
//
//  Created by Michael Vitone on 3/28/14.
//  Copyright (c) 2014 Michael Vitone. All rights reserved.
//

#import "Quiz6MasterViewController.h"

#import "Quiz6DetailViewController.h"
#import "Task.h"

@implementation Quiz6MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    tasks = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{

    Task *newTask = [[Task alloc] init];
    
    [newTask setName:@"New Task"];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [today dateByAddingTimeInterval:60*60*24];
    
    [newTask setDueDate:newDate];
    
    [newTask setUrgency:0];
    
    [tasks addObject:newTask];
    
    [[self tableView] reloadData];

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    int index = [indexPath row];
    
    Task *task = [tasks objectAtIndex:index];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    NSString *formattedDate = [formatter stringFromDate:task.dueDate];
    
    cell.textLabel.text = task.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%.2f)", formattedDate, task.urgency];
    
    [[cell textLabel] setTextColor:[UIColor colorWithRed:task.urgency/10.0f green:1-task.urgency/10.0f blue:0.0 alpha:0.5f]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    Quiz06DetailViewController *detailViewController = [[Quiz06DetailViewController alloc] initWithNibName:@"Quiz06DetailViewController" bundle:nil];
    
    
    [detailViewController setTask:[tasks objectAtIndex:[indexPath row]]];
    
    [detailViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:navController animated:YES completion:nil];
}
 */




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    Quiz6DetailViewController *detailViewController = [segue destinationViewController];
    [detailViewController setCurrentTask:[tasks objectAtIndex:[[self.tableView indexPathForSelectedRow] row]]];
    
    [detailViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
    
  
}
 


@end
