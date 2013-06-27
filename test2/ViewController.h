//
//  ViewController.h
//  test2
//
//  Created by Mark Crippen on 6/16/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIView *tabsView;
@property(weak, nonatomic)IBOutlet UIView *placeholderView;
@property(weak, nonatomic) UIViewController *currentViewController;

- (IBAction)prayerButton:(UIButton *)sender;
@end
