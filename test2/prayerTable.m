//
//  prayerTable.m
//  test2
//
//  Created by Mark Crippen on 6/19/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "prayerTable.h"
#import "PrayerCell.h"
#import "PrayerDetailViewController.h"

@interface prayerTable ()

@end

@implementation prayerTable


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
    NSLog(@"View did load!");
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://sojourn.markcrippen.com/prayerwall.php"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    news = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    NSLog(@"%@", news);
    
    [MyTableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)loadError
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry this didnt work for you, please try again" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"memory warning");
    
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
    return [news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    PrayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    
    NSLog(@"tableview frame %@", NSStringFromCGRect(tableView.frame));
    
    if (cell == nil) {
        NSLog(@"cell is Nil");
        cell = [[PrayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
    }
    
    
    cell.dName.text = [[news objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    cell.priority.text = [[news objectAtIndex:indexPath.row]objectForKey:@"priority"];
    cell.dateTime.text = [[news objectAtIndex:indexPath.row] objectForKey:@"datetime"];
    cell.numPraying.text = @"2 praying";
    cell.requestPreview.text = [[news objectAtIndex:indexPath.row] objectForKey:@"request"];
    
    return cell;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    PrayerDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"PrayerDetailViewController"];
    
    detail.detailText = [[news objectAtIndex:indexPath.row] objectForKey:@"request"];
    detail.detailNameText = [[news objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    detail.detailDateText= [[news objectAtIndex:indexPath.row] objectForKey:@"datetime"];
    
    
    //detail.detailTextLabel = [[NSString stringWithFormat:[news objectAtIndex:indexPath.row]]];
                              
    //detail.num = [[NSString stringWithFormat:[heads objectAtIndex:indexPath.row]] intValue];
   
  // NSString *cellvalue=[[news objectAtIndex:indexPath.row] objectForKey:@"request"];
    //detail->detailText = [NSString stringWithFormat: cellvalue];
    //NSDictionary *dict = [news objectAtIndex: indexPath.row];
    //detail.detailTextLabel = [dict objectForKey:@"name"];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
