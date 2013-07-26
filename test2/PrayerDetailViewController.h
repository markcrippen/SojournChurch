//
//  PrayerDetailViewController.h
//  test2
//
//  Created by Mark Crippen on 6/25/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface PrayerDetailViewController : GAITrackedViewController


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

- (IBAction)prayForYou:(id)sender;

@property (strong, nonatomic) NSString *detailText;
@property (strong, nonatomic) NSString *detailTitle;
@property (strong, nonatomic) NSString *detailDateText;
@property (strong, nonatomic) NSString *detailNameText;
@property (strong, nonatomic) NSString *detailID;






@end
