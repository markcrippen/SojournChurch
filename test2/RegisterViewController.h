//
//  RegisterViewController.h
//  test2
//
//  Created by Mark Crippen on 7/3/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *pass1;
@property (weak, nonatomic) IBOutlet UITextField *pass2;
@property (weak, nonatomic) IBOutlet UITextField *churchName;



- (IBAction)createUser:(id)sender;
- (IBAction)exitButton:(id)sender;
- (IBAction)clearKeyboard:(id)sender;


@end
