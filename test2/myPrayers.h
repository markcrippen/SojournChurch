//
//  myPrayers.h
//  SojournPrayer
//
//  Created by Mark Crippen on 8/16/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myPrayers : UITableViewController
{
    NSMutableArray *myarray;
    NSArray *news;
    NSMutableData *data;
    
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *navButton;
@property (strong, nonatomic) IBOutlet UITableView *myPrayersTable;

@end
