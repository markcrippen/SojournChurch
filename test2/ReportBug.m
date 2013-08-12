//
//  ReportBug.m
//  test2
//
//  Created by Mark Crippen on 8/8/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "ReportBug.h"
#import "SWRevealViewController.h"
#import "GAI.h"


@interface ReportBug ()

@end

@implementation ReportBug

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
    self.trackedViewName = @"About/Report Bug";
    
    
	// Do any additional setup after loading the view.
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showEmail:(id)sender {
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // or this format to show day of the week Sat,11-12-2011 23:27:09
    
    [dateFormatter setDateFormat:@"EEE,MM-dd-yyyy HH:mm:ss"];
    
    // Get the date time in NSString
    
    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    NSLog(@"%@", dateInStringFormated);
    //NSString *buddy = @"Hello world!";
    
    // Email Subject
    NSString *emailTitle = @"Bug Report";
    // Email Content
    NSString *messageBody = @"UH OH! I broke it :( \n What happened was: ";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"mac09a@acu.edu"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            [tracker sendException:NO withNSError:error];
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}@end
