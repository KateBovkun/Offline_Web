//
//  PageLoader.m
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/23/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import "PageLoader.h"

@implementation PageLoader

-(void) requestPage
{
    NSString *urlString = @"http://pionerskaya.ru/wp/CleanHTML/index-manifest.html";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:20.0f];
    
    
    responseData = [[NSMutableData alloc] init];
    myconnection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
}


-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{   
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        NSLog(@"did RecieveResponse %@, %@", httpResponse.MIMEType, httpResponse.description);
        //If you need the response, you can use it here
    }
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection %@ FAIL", connection.originalRequest.URL);
    [responseData release];
    [connection release];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection)
    {
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //You've got all the data now
        //Do something with your response string
        
        
        [responseString release];
    }
    
    [responseData release];
    [connection release];
}

@end
