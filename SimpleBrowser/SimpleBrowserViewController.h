//
//  SimpleBrowserViewController.h
//  SimpleBrowser
//
//  Created by Ben Copsey on 20/08/2011.
//  Copyright 2011 All-Seeing Interactive. All rights reserved.
//

//
//  Simple example of a viewcontroller that manages a UIWebView.
//  It changes the url in the address bar to point to our local webserver
//

#import <UIKit/UIKit.h>
#import "SDURLCache.h"
#import "SimpleBrowserDelegate.h"

@interface SimpleBrowserViewController : UIViewController <SimpleBrowserDelegate>
{
    NSString * cachePath;
	IBOutlet UIWebView *webView;
	IBOutlet UITextField *urlBar;
    IBOutlet UIButton *checkCache;
    SDURLCache * urlCache;
}

- (void)loadURL:(NSURL *)url;
- (IBAction)openURL:(id)sender;
- (IBAction)tapCheckButton:(id)sender;
- (IBAction)tapLocalButton:(id)sender;

@end
