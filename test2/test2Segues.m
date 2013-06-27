//
//  test2Segues.m
//  test2
//
//  Created by Mark Crippen on 6/18/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "test2Segues.h"
#import "ViewController.h"


@implementation test2Segues

-(void)perform{
        
        ViewController *src = (ViewController *)self.sourceViewController;
        UIViewController *dst = (UIViewController *) self.destinationViewController;
        
        for(UIView *view in src.placeholderView.subviews){
            [view removeFromSuperview];
        }
    

    
        src.currentViewController = dst;
        [src.placeholderView addSubview:dst.view];
    
}

@end
