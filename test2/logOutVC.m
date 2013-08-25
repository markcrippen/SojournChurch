//
//  logOutVC.m
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "logOutVC.h"
#import "SWRevealViewController.h"

@interface logOutVC ()

@end

@implementation logOutVC


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
    NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
    
    NSMutableString *someString = [NSMutableString stringWithString: @"You are logged in as "];
    [someString appendString: name];
    
    self.infoLabel.text = someString;
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

- (IBAction)logOutButton:(id)sender {
    //do stuff to logout the user
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginCheck"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log out" message:@"You have been logged out" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
    //possibly show a message box?
    
}
@end
