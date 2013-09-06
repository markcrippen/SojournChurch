//
//  myPrayersDetail.m
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "myPrayersDetail.h"

@interface myPrayersDetail ()

@end

@implementation myPrayersDetail

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
    
    self.trackedViewName = @"My Prayers Detail";
    
    self.titleLabel.text = self.detailTitle;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.preferredMaxLayoutWidth = 270.0f;
    
    self.detailTextView.text = self.detailText;
    
    self.nameLabel.text = self.detailNameText;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formatterDate = [inputFormatter dateFromString:self.detailDateText];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EE MM/dd/yy h:mm a"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    
    self.dateLabel.text = newDateString;
    self.dateLabel.preferredMaxLayoutWidth = 175.0f;
    self.dateLabel.numberOfLines = 1;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteButton:(id)sender {
    
    NSLog(@"IdNum %@", self.IdNum);
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"id=%@", self.IdNum];
    
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
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"the request has been deleted" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //UINavigationController *navController;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UH OH" message:response delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
        [alertView show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
}
@end
