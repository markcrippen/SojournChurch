//
//  loginViewController.m
//  test2
//
//  Created by Mark Crippen on 6/21/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController
@synthesize userName,passWord;


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

- (IBAction)loginButton:(id)sender {
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    
    
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"username=%@&password=%@",userName.text, passWord.text];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/login.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    
    response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    //need to create if statement
    if ([response isEqualToString:@"Logged In"]) {
        NSLog(@"%@",response);
        [[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"loginCheck"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logged In" message:@"You have been logged in" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UH-OH" message:@"Your Username and/or password are not correct" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
        [alertView show];

        NSLog(@"hit the else: %@", response);
    }
    
}


- (IBAction)backButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
