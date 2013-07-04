//
//  RegisterViewController.m
//  test2
//
//  Created by Mark Crippen on 7/3/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize userName,pass1,pass2,email,churchName;

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

- (IBAction)createUser:(id)sender {
    
    //this is where the POST call is going to go
    
    [self.userName resignFirstResponder];
    [self.pass1 resignFirstResponder];
    [self.pass2 resignFirstResponder];
    [self.email resignFirstResponder];
    [self.churchName resignFirstResponder];
    //grab the device for analytics and user profiles
    
    NSString *device = [[UIDevice currentDevice] model];
    NSString *deviceName = [[UIDevice currentDevice] name];
    
    NSLog(@"Device Name is: %@", deviceName);
    NSLog(@"Device is: %@",device);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //put in an IF statement to compare the two password fields
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&church=%@&device=%@",userName.text, pass1.text, email.text, churchName.text, device];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://sojourn.markcrippen.com/createuser.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    
    response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //need to create if statement
    if ([response isEqualToString:@"User Created"]) {
        NSLog(@"%@",response);
        [[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"loginCheck"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"User Created" message:@"You have been logged in" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UH-OH" message:response delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
        [alertView show];
        
        NSLog(@"hit the else: %@", response);
    }
}

- (IBAction)exitButton:(id)sender {
    //need to close out the view
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)clearKeyboard:(id)sender {
    [self.userName resignFirstResponder];
    [self.pass1 resignFirstResponder];
    [self.pass2 resignFirstResponder];
    [self.email resignFirstResponder];
    [self.churchName resignFirstResponder];
}
@end
