//
//  myPrayersDetail.h
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface myPrayersDetail : GAITrackedViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;




@property (strong, nonatomic) NSString *detailText;
@property (strong, nonatomic) NSString *detailTitle;
@property (strong, nonatomic) NSString *detailDateText;
@property (strong, nonatomic) NSString *detailNameText;

@end
