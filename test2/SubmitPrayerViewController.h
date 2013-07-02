//
//  SubmitPrayerViewController.h
//  test2
//
//  Created by Mark Crippen on 6/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitPrayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *prayerRequest;


- (IBAction)requestTypeButton:(UISegmentedControl *)sender;


- (IBAction)anonPlug:(UISwitch *)sender;

- (IBAction)exitButton:(UIButton *)sender;
- (IBAction)submitButton:(id)sender;

@end
