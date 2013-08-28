//
//  myPrayers.m
//  SojournPrayer
//
//  Created by Mark Crippen on 8/16/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "myPrayers.h"
#import "GAI.h"
#import "SWRevealViewController.h"
#import "myPrayersCell.h"
#import "myPrayersDetail.h"


@interface myPrayers ()

@end

@implementation myPrayers

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
    [tracker sendView:@"My Prayer Requests"];
    
    // Change button color
    _navButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _navButton.target = self.revealViewController;
    _navButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title = @"My Prayer Requests";
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky1"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 10, 10, 0);
    self.tableView.contentInset = inset;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"]){
        //i want to do a GET call here
        NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
        
        NSMutableString *urlString = [NSMutableString stringWithString: @"http://sojourn.markcrippen.com/myPrayerLog.php?name="];
        [urlString appendString: name];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
        refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
        [refresh addTarget:self
                    action:@selector(refreshMyTable:)
          forControlEvents:UIControlEventValueChanged];
        self.refreshControl = refresh;
    }
    
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Logged in" message:@"Please login before you submit" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
        [alertView show];
    }
    
    
    
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
    
    NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
    
    NSMutableString *urlString = [NSMutableString stringWithString: @"http://sojourn.markcrippen.com/myPrayerLog.php?name="];
    [urlString appendString: name];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
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
    news = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    NSLog(@"%@", news);
    
    [_myPrayersTable reloadData];
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myPrayersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myPrayersCell"];
    
    if (cell == nil) {
        NSLog(@"cell is Nil");
        cell = [[myPrayersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myPrayersCell"];
    }
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formatterDate = [inputFormatter dateFromString:[[news objectAtIndex:indexPath.row] objectForKey:@"datetime"]];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EE MM/dd/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    
    
    cell.nameLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    cell.dateLabel.text = newDateString;
    cell.titleLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    
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
    myPrayersDetail *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"myPrayersDetail"];
    
    detail.detailText = [[news objectAtIndex:indexPath.row] objectForKey:@"request"];
    detail.detailNameText = [[news objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    detail.detailDateText= [[news objectAtIndex:indexPath.row] objectForKey:@"datetime"];
    detail.detailTitle = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    
    [self.navigationController pushViewController:detail animated:YES];}

@end
