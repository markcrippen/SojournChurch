//
//  myPraiseTable.h
//  SojournPrayer
//
//  Created by Mark Crippen on 9/6/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myPraiseTable : UITableViewController
{
    NSMutableArray *myarray;
    NSMutableArray *news;
    NSMutableData *data;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarButton;
@property (strong, nonatomic) IBOutlet UITableView *myPraiseTable;

@end
