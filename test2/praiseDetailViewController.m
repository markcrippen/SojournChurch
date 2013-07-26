//
//  praiseDetailViewController.m
//  test2
//
//  Created by Mark Crippen on 7/15/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "praiseDetailViewController.h"

@interface praiseDetailViewController ()

@end

@implementation praiseDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.trackedViewName = @"Praise Detail";
    
    self.titleLabel.text = self.detailTitle;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.preferredMaxLayoutWidth = 270.0f;
    
    self.detailLabel.text = self.detailText;
    
    self.nameLabel.text = self.detailNameText;
    
    self.dateLabel.text = self.detailDateText;
       self.dateLabel.preferredMaxLayoutWidth = 175.0f;
       self.dateLabel.numberOfLines = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
