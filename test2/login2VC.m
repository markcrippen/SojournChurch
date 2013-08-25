//
//  login2VC.m
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "login2VC.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"

@interface login2VC ()

@end

@implementation login2VC
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
    self.trackedViewName = @"2nd Login View";
    
    userName.delegate = self;
    passWord.delegate = self;

    _navButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _navButton.target = self.revealViewController;
    _navButton.action = @selector(revealToggle:);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == passWord){
        
        if ([passWord.text length] == 0)
        {
            textField.layer.cornerRadius=8.0f;
            textField.layer.masksToBounds=YES;
            textField.layer.borderColor=[[UIColor redColor]CGColor];
            textField.layer.borderWidth= 1.0f;
            
        }
        else{
            textField.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
    }
    
    else if(textField == userName){
        
        if ([userName.text length] == 0){
            
            textField.layer.cornerRadius=8.0f;
            textField.layer.masksToBounds=YES;
            textField.layer.borderColor=[[UIColor redColor]CGColor];
            textField.layer.borderWidth= 1.0f;
        }
        else{
            textField.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //this handles the length of the textfield
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 25) ? NO : YES; //nothing greater than 25 characters
}
// Implement the UITextFieldDelegate in the .h file
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField.text length ] > 1){
        textField.layer.borderColor=[[UIColor clearColor]CGColor];
        [textField resignFirstResponder];
        return YES;
    }
    
    else{
        textField.layer.cornerRadius=8.0f;
        textField.layer.masksToBounds=YES;
        textField.layer.borderColor=[[UIColor redColor]CGColor];
        textField.layer.borderWidth= 1.0f;
        return NO;
    }
    
    
}



- (IBAction)loginButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if ([userName.text length] >1 && [passWord.text length] >1){
        
        
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
        
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error: nil];
        // Log Response
        NSString *response = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",response);
        
        response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //need to create if statement
        if ([response isEqualToString:@"Logged In"]) {
            NSLog(@"%@",response);
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"loginCheck"];
            [[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"loginName"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logged In" message:@"You have been logged in" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
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
    else{
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill out the form" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [errorView show];
        
    }

    
}

- (IBAction)clearKeyboard:(id)sender {
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    
}
@end
