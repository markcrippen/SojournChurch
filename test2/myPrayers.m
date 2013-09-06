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
    [tracker sendView:@"Who im Praying for"];
    
    // Change button color
    _navButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _navButton.target = self.revealViewController;
    _navButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title = @"I'm Praying for you";
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky1"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 10, 10, 0);
    self.tableView.contentInset = inset;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"]){

        [self refreshView];
        
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

-(void)refreshView{
    NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
    NSMutableString *urlString = [NSMutableString stringWithString: @"http://sojourn.markcrippen.com/myPrayerLog.php?name="];
    [urlString appendString: name];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)refreshMyTable:(UIRefreshControl *)refreshControl {
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating..."];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self refreshView];
    [refreshControl endRefreshing];
}

-(void)viewDidAppear:(BOOL)animated{
    [self refreshView];
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
    NSError *errorString = nil;
    
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error: &errorString];
    if(!news){
        NSLog(@"%@", errorString);
        //notify user of the error
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker sendException:NO withNSError:errorString];
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error, please try again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [errorView show];
    }
    else{
        NSLog(@"%@", news);
        [_myPrayersTable reloadData];
    }
    

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


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (UITableViewCellEditingStyle)tableView:(UITableView *)theTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"edit? ");
        NSString *idNumber = [[news objectAtIndex:indexPath.row] objectForKey:@"ID"];
        //call the delete script
        NSLog(@"ID Number %@", idNumber);
        
        NSString *myRequestString = [NSString stringWithFormat:@"id=%@", idNumber];
        
        // Create Data from request
        NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/deletePrayingFor.php"]];
        // set Request Type
        [request setHTTPMethod: @"POST"];
        // Set content-type
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        // Set Request Body
        [request setHTTPBody: myRequestData];
        
        // Now send a request and get Response
        NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
        // Log Response
        NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",response);
        
        response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([response isEqualToString:@"the record has been deleted"]) {
            //no alert view because the table is going to refresh
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        
        else{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UH OH" message:response delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            [alertView show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        //call the refresh function to reload the data in the table
        //[self refreshFunction];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myPrayersDetail *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"myPrayersDetail"];
    
    detail.detailText = [[news objectAtIndex:indexPath.row] objectForKey:@"request"];
    detail.detailNameText = [[news objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    detail.detailDateText= [[news objectAtIndex:indexPath.row] objectForKey:@"datetime"];
    detail.detailTitle = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    detail.IdNum = [[news objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    [self.navigationController pushViewController:detail animated:YES];

}

@end
