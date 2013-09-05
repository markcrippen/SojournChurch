//
//  ConnectionClass.m
//  SojournPrayer
//
//  Created by Mark Crippen on 9/1/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import "ConnectionClass.h"



@implementation ConnectionClass

/*
-(NSString *)connectionMethod:(NSString*) UrlConnection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:UrlConnection];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
 
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSError *errorString = nil;
    
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error: &errorString];
    if(!news){
        NSlog(@"%@", errorString);
        //notify user of the error
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker sendException:NO withNSError:errorString];
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error, please try again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [errorView show];
    }
    else{
        NSLog(@"%@", news);
        [MyTableView reloadData];
    }
}
     

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)loadError
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker sendException:NO withNSError:loadError];
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry this didnt work for you, please try again" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}
*/


@end
