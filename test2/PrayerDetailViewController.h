//
//  PrayerDetailViewController.h
//  test2
//
//  Created by Mark Crippen on 6/25/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrayerDetailViewController : UIViewController



@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
- (IBAction)prayForYou:(id)sender;

@property (strong, nonatomic) NSString *detailText;
@property (strong, nonatomic) NSString *detailTitle;
@property (strong, nonatomic) NSString *detailDateText;
@property (strong, nonatomic) NSString *detailNameText;







@end
