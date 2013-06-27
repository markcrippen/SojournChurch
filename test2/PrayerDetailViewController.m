//
//  PrayerDetailViewController.m
//  test2
//
//  Created by Mark Crippen on 6/25/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "PrayerDetailViewController.h"
#import "prayerTable.h"

@interface PrayerDetailViewController ()

@end

@implementation PrayerDetailViewController


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
    self.detailTextLabel.text = self.detailText;
        self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.preferredMaxLayoutWidth = 270.0f;
    
    self.nameLable.text = self.detailNameText;
    
    
    self.dateLable.text = self.detailDateText;
    self.dateLable.preferredMaxLayoutWidth = 150.0f;
    self.dateLable.numberOfLines = 1;
    
    
    //[self.detailTextLabel setNumberOfLines:10];
    //[self.detailTextLabel sizeToFit];
    NSLog(@"%@",self.detailTextLabel);
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
