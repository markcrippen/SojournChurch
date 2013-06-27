//
//  PrayerCell.h
//  test2
//
//  Created by Mark Crippen on 6/19/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrayerCell : UITableViewCell

@property (weak, nonatomic)IBOutlet UILabel *requestPreview;
@property (weak, nonatomic)IBOutlet UILabel *dName;
@property (weak, nonatomic)IBOutlet UILabel *dateTime;
@property (weak, nonatomic)IBOutlet UILabel *numPraying;
@property (weak, nonatomic)IBOutlet UILabel *priority;



@end
