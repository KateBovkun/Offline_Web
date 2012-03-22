//
//  ListViewController.h
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/22/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleBrowserViewController.h"
#import "SDURLCache.h"

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIWebView* listWebView;
    IBOutlet UITableView* listTableView;
    NSArray * tableData;
}

@property (nonatomic, retain) SimpleBrowserViewController * delegate;
@property (nonatomic, retain) SDURLCache * cache;

-(IBAction)tapBackButton:(id)sender;

@end
