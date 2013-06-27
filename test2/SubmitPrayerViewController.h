//
//  SubmitPrayerViewController.h
//  test2
//
//  Created by Mark Crippen on 6/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitPrayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *prayerRequest;

- (IBAction)anonPlug:(UISwitch *)sender;


@property (weak, nonatomic) IBOutlet UISlider *urgencySlider;
- (IBAction)exitButton:(UIButton *)sender;
- (IBAction)submitButton:(id)sender;

@end
