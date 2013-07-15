//
//  SubmitPrayerViewController.h
//  test2
//
//  Created by Mark Crippen on 6/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitPrayerViewController : UIViewController
//outlets
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *prayerRequest;
@property (weak, nonatomic) IBOutlet UISwitch *anonPlug;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *LoginNavButton;


//actions
- (IBAction)anonPlug:(UISwitch *)sender;
- (IBAction)requestTypeButton:(UISegmentedControl *)sender;
- (IBAction)exitButton:(UIButton *)sender;
- (IBAction)submitButton:(id)sender;
- (IBAction)LoginButtonAction:(UIBarButtonItem *)sender;

@end
