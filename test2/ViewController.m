//
//  ViewController.m
//  test2
//
//  Created by Mark Crippen on 6/16/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSArray *news;
NSMutableData *data;

@synthesize tabsView, placeholderView, currentViewController;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"home"]
       || [segue.identifier isEqualToString:@"heart"]
       || [segue.identifier isEqualToString:@"cogs"]){
        
        for (UIButton *b in self.tabsView.subviews) {
            [b setSelected:NO];
        }
        
        UIButton *button = (UIButton *)sender;
        [button setSelected:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void) displayContentController: (UIViewController*) content;
{
   // [self addChildViewController:currentViewController];                 // 1
    //content.view.frame = [self frameForContentController]; // 2
    //[self.view addSubview:self.currentClientView];
    //[content didMoveToParentViewController:self];          // 3
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)prayerButton:(UIButton *)sender {
    
    
}
@end
