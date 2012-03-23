//
//  PageLoader.h
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/23/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageLoader : NSObject <NSURLConnectionDataDelegate>
{
    NSURLConnection * myconnection;
    NSMutableData * responseData;
}

-(void) requestPage;

@end
