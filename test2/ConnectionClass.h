//
//  ConnectionClass.h
//  SojournPrayer
//
//  Created by Mark Crippen on 9/1/13.
//  Copyright (c) 2013 Mark Crippen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionClass : NSObject
{
    NSString *UrlConnection;
    NSArray *news;
    NSMutableData *data;
    
}

@end
