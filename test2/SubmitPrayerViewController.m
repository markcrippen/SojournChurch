//
//  SubmitPrayerViewController.m
//  test2
//
//  Created by Mark Crippen on 6/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "SubmitPrayerViewController.h"
#import "SWRevealViewController.h"
#import "loginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GAI.h"



@interface SubmitPrayerViewController ()

@end

@implementation SubmitPrayerViewController

NSString *name;
NSNumber *segValue;
NSString *dName;

NSString *loginCheck;


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
    self.trackedViewName=@"Submit View";
    
    self.title = @"Submit";
    self.titleField.delegate = self;
    self.prayerRequest.delegate = self;
    
    //loginCheck = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
   
   // _LoginNavButton.target = self.view;
   // _LoginNavButton.action = @selector(LoginButtonAction:);
    
    _titleField.layer.cornerRadius=8.0f;
    _titleField.layer.masksToBounds=YES;
    _titleField.layer.borderColor=[[UIColor grayColor]CGColor];
    _titleField.layer.borderWidth= 1.0f;
    
    _prayerRequest.layer.cornerRadius=8.0f;
    _prayerRequest.layer.masksToBounds=YES;
    _prayerRequest.layer.borderColor=[[UIColor clearColor]CGColor];
    _prayerRequest.layer.borderWidth= 1.0f;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"])
    {

        _LoginNavButton.title = @"Log Out";
        
    }
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)textViewDidBeginEditing:(UITextView *)textView{
   //clears the placeholder text in the textview.
    
    if([textView.text isEqualToString:@"Details"]){
        textView.text =@"";
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //this handles the length of the textfield
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 75) ? NO : YES; //nothing greater than 75 characters
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestTypeButton:(UISegmentedControl *)sender {
          
        UISegmentedControl *segmented = (UISegmentedControl *)sender;
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
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
   
    
   [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Submit prayer" withAction:@"buttonClick" withLabel:@"submit type" withValue:segValue];

}

- (IBAction)anonPlug:(UISwitch *)sender {
    if (_anonPlug.on){
        NSLog(@"Anonplug is on");
        dName = @"Anonymous";
         [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Submit prayer" withAction:@"buttonClick" withLabel:@"anon plug on" withValue:[NSNumber numberWithInteger:1]];
    }
    else{
        
      dName = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"];
        [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Submit prayer" withAction:@"buttonClick" withLabel:@"anon plug off" withValue:[NSNumber numberWithInteger:2]];
        
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

    if([dName isEqualToString:NULL]){
        dName = @"anonymous";
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"]){
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
      name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
    
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
                    self.titleField.text = @"";
                    self.prayerRequest.text = @"";
                }
        
                else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UH OH" message:response delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                    [alertView show];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }
        
            }
        }
    
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Logged in" message:@"Please login before you submit" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)LoginButtonAction:(UIBarButtonItem *)sender {
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"] isEqualToString:@"yes"]){
               
        NSLog(@"I am going to Logout");
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginCheck"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _LoginNavButton.title = @"Login";
        
    }
    else{
        loginViewController *loginModal = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginModal animated:YES completion:nil];
    }
    
    NSLog(@"dynamic button was fired");
}
@end
