//
//  myRequests.h
//  SojournPrayer
//
//  Created by Mark Crippen on 8/16/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myRequests : UITableViewController <UITableViewDelegate>
{
    NSMutableArray *myarray;
    NSMutableArray *news;
    NSMutableData *data;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *navButton;

@property (strong, nonatomic) IBOutlet UITableView *myRequestsTable;

@end
