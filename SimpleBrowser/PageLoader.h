//
//  PageLoader.h
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/23/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "SimpleBrowserDelegate.h"

@interface PageLoader : NSObject <NSURLConnectionDataDelegate, ASIHTTPRequestDelegate>
{
    NSURLConnection * myconnection;
    NSMutableData * responseData;
}

@property (nonatomic, retain) id<SimpleBrowserDelegate> delegate;

-(void) requestPage;
-(void) requestPageWithURL:(NSURL*)url;
-(void) requestPageWithURLString:(NSString *)urlString;
-(void) ASIRequestPageWithURL:(NSURL *)url;

@end
