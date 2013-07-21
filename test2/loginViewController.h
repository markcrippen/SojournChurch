//
//  loginViewController.h
//  test2
//
//  Created by Mark Crippen on 6/21/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController <UITextFieldDelegate>
{
    NSMutableData *responseData;
}



@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;


- (IBAction)loginButton:(id)sender;
- (IBAction)backButton:(UIButton *)sender;
- (IBAction)clearKeyboardButton:(UIButton *)sender;


@end
