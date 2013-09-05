//
//  praiseTable.m
//  test2
//
//  Created by Mark Crippen on 6/26/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "praiseTable.h"
#import "praiseCell.h"
#import "SWRevealViewController.h"
#import "praiseDetailViewController.h"
#import "GAI.h"

@interface praiseTable ()

@end

@implementation praiseTable

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
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // manual screen tracking
    [tracker sendView:@"Praise Wall"];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky1"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://sojourn.markcrippen.com/praisewall.php"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refresh addTarget:self
                action:@selector(refreshMyTable:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
}

- (void)refreshMyTable:(UIRefreshControl *)refreshControl {
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating..."];
    NSLog(@"refreshMyTable");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://sojourn.markcrippen.com/praisewall.php"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [refreshControl endRefreshing];
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
    praiseArray = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    NSLog(@"%@", praiseArray);
    
    [MyTableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)loadError
{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker sendException:NO withNSError:loadError];
    
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry this didnt work for you, please try again" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
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
    return [praiseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    praiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"praiseCell"];
    
    NSLog(@"tableview frame %@", NSStringFromCGRect(tableView.frame));
    
    if (cell == nil) {
        NSLog(@"cell is Nil");
        cell = [[praiseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"praiseCell"];
    }
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formatterDate = [inputFormatter dateFromString:[[praiseArray objectAtIndex:indexPath.row] objectForKey:@"dateTime"]];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EE MM/dd/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    
    
    cell.name.text = [[praiseArray objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    cell.praiseDate.text = newDateString;
    cell.praiseTitle.text = [[praiseArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
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
    praiseDetailViewController *praiseDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"praiseDetailViewController"];
    
    praiseDetail.detailText = [[praiseArray objectAtIndex:indexPath.row] objectForKey:@"praiseNote"];
    praiseDetail.detailNameText = [[praiseArray objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    praiseDetail.detailDateText= [[praiseArray objectAtIndex:indexPath.row] objectForKey:@"dateTime"];
    praiseDetail.detailTitle = [[praiseArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    [self.navigationController pushViewController:praiseDetail animated:YES];
}

@end
