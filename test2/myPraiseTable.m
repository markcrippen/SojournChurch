//
//  myPraiseTable.m
//  SojournPrayer
//
//  Created by Mark Crippen on 9/6/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "myPraiseTable.h"
#import "GAI.h"
#import "myPraiseTableCell.h"
#import "SWRevealViewController.h"
#import "myPraiseDetail.h"

@interface myPraiseTable ()

@end

@implementation myPraiseTable

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
    [super viewDidLoad];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // manual screen tracking
    [tracker sendView:@"My Praise Wall"];
    
    // Change button color
    _navBarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _navBarButton.target = self.revealViewController;
    _navBarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title = @"My Praise Wall";
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky1"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 10, 10, 0);
    self.tableView.contentInset = inset;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"]){
        //i want to do a GET call here
        NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
        
        NSMutableString *urlString = [NSMutableString stringWithString: @"http://sojourn.markcrippen.com/myPraiseWall.php?name="];
        [urlString appendString: name];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:request delegate:self];
        
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

-(void)refreshFunction{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
    NSMutableString *urlString = [NSMutableString stringWithString: @"http://sojourn.markcrippen.com/myPraiseWall.php?name="];
    [urlString appendString: name];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void) viewWillAppear:(BOOL)animated{
    [self refreshFunction];
}
- (void)refreshMyTable:(UIRefreshControl *)refreshControl {
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating..."];
    [self refreshFunction];
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
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", news);
    NSLog(@"I am Finished!");
    [self.myPraiseTable reloadData];
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
    myPraiseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myPraiseTableCell"];
    
    if (cell == nil) {
        NSLog(@"cell is Nil");
        cell = [[myPraiseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myPraiseTableCell"];
    }
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formatterDate = [inputFormatter dateFromString:[[news objectAtIndex:indexPath.row] objectForKey:@"dateTime"]];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EE MM/dd/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    
    //cell.title.text = [[news objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    cell.date.text = newDateString;
    //cell.numPraying.text = [[news objectAtIndex:indexPath.row] objectForKey:@"numPraying"];
    cell.title.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    
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
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/deletePraise.php"]];
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
        [self refreshFunction];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    myPraiseDetail *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"myPraiseDetail"];
    
    detail.detailText = [[news objectAtIndex:indexPath.row] objectForKey:@"praiseNote"];
    detail.detailNameText = [[news objectAtIndex:indexPath.row] objectForKey:@"displayName"];
    detail.detailDateText= [[news objectAtIndex:indexPath.row] objectForKey:@"dateTime"];
    detail.detailTitle = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    detail.idNum = [[news objectAtIndex:indexPath.row] objectForKey:@"ID"];
    
    //detail.detailID = [[news objectAtIndex:indexPath.row] objectForKey:@"ID"];
    
    //detail.detailTextLabel = [[NSString stringWithFormat:[news objectAtIndex:indexPath.row]]];
    
    //detail.num = [[NSString stringWithFormat:[heads objectAtIndex:indexPath.row]] intValue];
    
    // NSString *cellvalue=[[news objectAtIndex:indexPath.row] objectForKey:@"request"];
    //detail->detailText = [NSString stringWithFormat: cellvalue];
    //NSDictionary *dict = [news objectAtIndex: indexPath.row];
    //detail.detailTextLabel = [dict objectForKey:@"name"];
    
    [self.navigationController pushViewController:detail animated:YES];}

@end
