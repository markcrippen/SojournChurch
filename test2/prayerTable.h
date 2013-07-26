//
//  prayerTable.h
//  test2
//
//  Created by Mark Crippen on 6/19/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"


@interface prayerTable : UITableViewController
{
    
    IBOutlet UITableView *MyTableView;
    NSMutableArray *myarray;
    NSArray *news;
    NSMutableData *data;
    
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
