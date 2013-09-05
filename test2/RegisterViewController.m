//
//  RegisterViewController.m
//  test2
//
//  Created by Mark Crippen on 7/3/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "RegisterViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>


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
    
    //turn into a UIwebview
    
    
    self.trackedViewName = @"Registration View";
    
    userName.delegate = self;
    pass1.delegate = self;
    pass2.delegate = self;
    email.delegate = self;
    churchName.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == userName){
        
        if ([userName.text length] == 0)
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
    
    else if(textField == pass1){
        
        if ([pass1.text length] < 7){
            
            textField.layer.cornerRadius=8.0f;
            textField.layer.masksToBounds=YES;
            textField.layer.borderColor=[[UIColor redColor]CGColor];
            textField.layer.borderWidth= 1.0f;
        }
        else{
            textField.layer.borderColor=[[UIColor clearColor]CGColor];
        }
        
    }
    else if(textField == pass2){
        
        if ([pass2.text length] < 7){
            
            textField.layer.cornerRadius=8.0f;
            textField.layer.masksToBounds=YES;
            textField.layer.borderColor=[[UIColor redColor]CGColor];
            textField.layer.borderWidth= 1.0f;
        }
        else{
            textField.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
    }
    else if(textField == churchName){
        
        if ([churchName.text length] < 1 ){
            
            textField.layer.cornerRadius=8.0f;
            textField.layer.masksToBounds=YES;
            textField.layer.borderColor=[[UIColor redColor]CGColor];
            textField.layer.borderWidth= 1.0f;
        }
        else{
            textField.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
    }
    
    else if(textField == email){
        
        if ([email.text length] < 1){
            //do i want to validate that?
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
    

// Implement the UITextFieldDelegate in the .h file
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)exitButton:(id)sender {
    //need to close out the view
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)registerButton:(id)sender {
    
    NSString *device = [[UIDevice currentDevice] model];
    NSString *deviceName = [[UIDevice currentDevice] name]; //what do we want to capture? or do we want analytics to cover this?
    
    NSLog(@"Device Name is: %@", deviceName);
    NSLog(@"Device is: %@",device);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //put in an IF statement to compare the two password fields
    
    if ([self.pass1.text isEqualToString:self.pass2.text]){
        
        // Create your request string with parameter name as defined in PHP file
        NSString *myRequestString = [NSString stringWithFormat:@"username=%@&password1=%@&email=%@&church=%@&device=%@",userName.text, pass1.text, email.text, churchName.text, device];
        
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
        if ([response isEqualToString:@"User Created!"]) {
            NSLog(@"%@",response);
            [[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"loginCheck"];
            [[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"loginName"];
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
}

@end