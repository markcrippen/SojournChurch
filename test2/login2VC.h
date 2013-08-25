//
//  login2VC.h
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"


@interface login2VC : GAITrackedViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *navButton;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

- (IBAction)loginButton:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)clearKeyboard:(id)sender;



@end
