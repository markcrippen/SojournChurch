//
//  myPraiseDetail.h
//  SojournPrayer
//
//  Created by Mark Crippen on 9/6/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface myPraiseDetail : GAITrackedViewController


@property (weak, nonatomic) NSString *detailText;
@property (weak, nonatomic) NSString *detailTitle;
@property (weak, nonatomic) NSString *detailDateText;
@property (weak, nonatomic) NSString *detailNameText;
@property (weak, nonatomic) NSString *idNum;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *praiseDetail;
- (IBAction)deleteButton:(id)sender;

@end
