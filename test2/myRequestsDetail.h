//
//  myRequestsDetail.h
//  SojournPrayer
//
//  Created by Mark Crippen on 8/24/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface myRequestsDetail : GAITrackedViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

- (IBAction)deleteButton:(id)sender;

@property (weak, nonatomic) NSString *detailText;
@property (weak, nonatomic) NSString *detailTitle;
@property (weak, nonatomic) NSString *detailDateText;
@property (weak, nonatomic) NSString *detailNameText;
@property (weak, nonatomic) NSString *idNum;

@end
