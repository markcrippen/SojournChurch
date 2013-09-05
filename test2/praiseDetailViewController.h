//
//  praiseDetailViewController.h
//  test2
//
//  Created by Mark Crippen on 7/15/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface praiseDetailViewController : GAITrackedViewController


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailLabel;

@property (weak, nonatomic) NSString *detailText;
@property (weak, nonatomic) NSString *detailTitle;
@property (weak, nonatomic) NSString *detailDateText;
@property (weak, nonatomic) NSString *detailNameText;

@end
