//
//  praiseTable.h
//  test2
//
//  Created by Mark Crippen on 6/26/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface praiseTable : UITableViewController
{
    

    IBOutlet UITableView *MyTableView;
    NSMutableArray *myarray;
    NSArray *praiseArray;
    NSMutableData *data;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
