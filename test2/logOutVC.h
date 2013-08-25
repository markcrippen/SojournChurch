//
//  logOutVC.h
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logOutVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)logOutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *navButton;

@end
