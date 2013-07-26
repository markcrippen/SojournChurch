//
//  PrayerDetailViewController.m
//  test2
//
//  Created by Mark Crippen on 6/25/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "PrayerDetailViewController.h"
#import "prayerTable.h"
#import "loginViewController.h"

@interface PrayerDetailViewController ()

@end

@implementation PrayerDetailViewController


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
    self.trackedViewName = @"Prayer Detail";
    
	// Do any additional setup after loading the view.
    self.titleLable.text = self.detailTitle;
        self.titleLable.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLable.numberOfLines = 2;
        self.titleLable.preferredMaxLayoutWidth = 260.0f;
        [_titleLable sizeToFit];
    
    self.textView.text = self.detailText;
           
    self.nameLable.text = self.detailNameText;
    
    
    self.dateLable.text = self.detailDateText;
        self.dateLable.preferredMaxLayoutWidth = 175.0f;
        self.dateLable.numberOfLines = 1;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)prayForYou:(id)sender {
    //need to add in the prayer iterator

    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"])
    {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
       NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
        
        // Create your request string with parameter name as defined in PHP file
        NSString *myRequestString = [NSString stringWithFormat:@"id=%@&name=%@", self.detailID, name];
        
        // Create Data from request
        NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
        
        //if the segment button is a pray request do this
       
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/numPraying.php"]];
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
            
            if ([response isEqualToString:@"1 row added"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Thank you for praying" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [alertView show];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UH OH" message:response delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                [alertView show];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
            }
            
        }
    else{
        
        loginViewController *loginModal = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginModal animated:YES completion:nil];
    }
    }   

@end

