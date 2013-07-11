//
//  SubmitPrayerViewController.m
//  test2
//
//  Created by Mark Crippen on 6/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "SubmitPrayerViewController.h"

@interface SubmitPrayerViewController ()

@end

@implementation SubmitPrayerViewController

NSString *name;
NSNumber *segValue;
NSString *dName;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestTypeButton:(UISegmentedControl *)sender {
          
        UISegmentedControl *segmented = (UISegmentedControl *)sender;
        
        switch (segmented.selectedSegmentIndex) {
            default:
                NSLog(@"Segment Item 1 selected.");
                segValue = [NSNumber numberWithInt:1];
                NSLog(@"%@", segValue);
                
                break;
            case 1:
                NSLog(@"Segment Item 2 selected.");
                segValue = [NSNumber numberWithInt:2];
                NSLog(@"%@", segValue);
                
                break;
        }

}

- (IBAction)anonPlug:(UISwitch *)sender {
    if (_anonPlug.on){
        NSLog(@"Anonplug is on");
        dName = @"Anonymous";
        
    }
    else{
        
      dName = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"];
        
    }
}
- (IBAction)exitButton:(UIButton *)sender {
    
    [self.prayerRequest resignFirstResponder];
    [self.titleField resignFirstResponder];
    
}

- (IBAction)submitButton:(id)sender {
    //I need to add a statement that will check if user is logged in
    //if not logged in, load the window to login, else continue
    [self.titleField resignFirstResponder];
    [self.prayerRequest resignFirstResponder];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
      name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"];
        
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"request=%@&name=%@&displayname=%@&title=%@", self.prayerRequest.text, name,dName, self.titleField.text];

    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
   
    //if the segment button is a pray request do this
    if ([segValue intValue] == 2) {
        NSLog(@"This is 2");
         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/createrequest.php"]];
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
        
        if ([response isEqualToString:@"1 record added"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Record has been added" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
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
        
         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/createPraise.php"]];
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
        NSLog(@" server response is: %@",response);
       
        response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
            if ([response isEqualToString:@"1 record added"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Record has been added" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
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
        
    }
@end
