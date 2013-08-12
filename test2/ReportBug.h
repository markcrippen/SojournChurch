//
//  ReportBug.h
//  test2
//
//  Created by Mark Crippen on 8/8/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "GAITrackedViewController.h"

@interface ReportBug : GAITrackedViewController <MFMailComposeViewControllerDelegate> // Add the delegate

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)showEmail:(id)sender;



@end
