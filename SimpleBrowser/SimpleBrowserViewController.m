//
//  SimpleBrowserViewController.m
//  SimpleBrowser
//
//  Created by Ben Copsey on 20/08/2011.
//  Copyright 2011 All-Seeing Interactive. All rights reserved.
//

#import "SimpleBrowserViewController.h"
#import "WorkWithCache.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "ListViewController.h"

@interface SimpleBrowserViewController ()
-(NSString*) checkURLBarText;
-(void) loadDataWithASI;
@end

@implementation SimpleBrowserViewController

#pragma mark View

- (void)viewDidLoad
{
    urlCache = [[[SDURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                         diskCapacity:1024*1024*5 // 5MB disk cache
                                                             diskPath:[SDURLCache defaultCachePath]] retain];
    [NSURLCache setSharedURLCache:urlCache];
   // ifMoSiButton.selected = YES;
    [self checkURLBarText];
    cachePath = nil;
	[super viewDidLoad];
}


- (void)webViewDidFinishLoad:(UIWebView *)wv
{
    
}

- (void) viewUnload
{
    for(UIView * subview in self.view.subviews)
    {
        [subview setHidden:NO];
    } 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)dealloc
{
    [urlCache release];
    [super dealloc];
}

#pragma mark Browser

- (IBAction)openURL:(id)sender
{
	[urlBar resignFirstResponder];
	NSURL *url = [NSURL URLWithString:[self checkURLBarText]];
	if (![url scheme]) {
		url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[urlBar text]]];
	}
	if (!url) {
		return;
	}
	[self loadURL:url];
}

- (void)loadURL:(NSURL *)url
{
    if (ifMoSiButton.selected) 
    {
        [self loadDataWithASI];
    }
	[webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:100]];
}

// We'll take over the page load when the user clicks on a link
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)theRequest navigationType:(UIWebViewNavigationType)navigationType
{
	
	// Other request types are often things like iframe content, we have no choice but to let UIWebView load them itself
	return YES;
}

- (IBAction)historyBack:(id)sender
{
	[webView goBack];
}

- (IBAction)historyForward:(id)sender
{
	[webView goForward];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self openURL:nil];
	return NO;
}

- (NSString*) checkURLBarText
{
    if (ifMoSiButton.selected) 
    {
        if (urlBar.text != @"http://pionerskaya.ru/wp/updating/date.html") 
        {
            urlBar.text = @"http://pionerskaya.ru/wp/updating/date.html";
            return urlBar.text;
        }
    }
    NSURL *url = [NSURL URLWithString:[urlBar text]];
    NSString * urlString = [urlBar text];
	if (![url scheme]) {
        urlString = [NSString stringWithFormat:@"http://%@",[urlBar text]];
		url = [NSURL URLWithString:urlString];
	}
	if (!url) {
		return nil;
	}
    return urlString;
}

- (void) refreshPage
{
    [loader release];
    NSURL* url = [NSURL URLWithString:[self checkURLBarText]];
    [webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:100]];
    NSDate *dateToday =[NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"ccc hh:mm"];
    NSString *string = [format stringFromDate:dateToday];
    message.text = [NSString stringWithFormat:@"Page change at %@",string];
    [format release];
}

#pragma mark Special

- (void) loadDataWithASI
{
    loader = [[PageLoader alloc] init];
    loader.delegate = self;
    [loader ASIRequestPageWithURL:[NSURL URLWithString:[self checkURLBarText]]];
}

- (IBAction)tapUseIfMoSi:(id)sender
{
    ifMoSiButton.selected = !ifMoSiButton.selected;
    if (!ifMoSiButton.selected) 
    {
        message.text = @"";
    }
    [self checkURLBarText];
}

- (IBAction)tapLocalButton:(id)sender
{
    for(UIView * view in self.view.subviews)
    {
        [view setHidden:YES];
    }
    ListViewController * listView = [[ListViewController alloc] init];
    listView.delegate = self;
    listView.cache = urlCache;
    [self.view addSubview:listView.view];
}


- (IBAction)tapCheckButton:(id)sender
{
    loader = [[PageLoader alloc] init];
    [loader requestPage];
    [loader release];
}
/*{
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-1.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-2.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-3.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-4.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-5.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-6.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-7.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-8.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-9.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-10.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-11.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-12.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-13.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-14.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-15.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-16.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-17.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-18.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-19.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-20.html"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/css/style-html5bp.css"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/css/articleViewStyles.css"]];
    [urlCache isCached:[NSURL URLWithString:@"http://ddarchive.net/wp-projects/ipad2/html5-test/js/swipeview.js"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Others/Images/2012-03-06/v%201_1331040840.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Production/Digital/homepage/Images/509058895.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Local/Images/MONITOR006_1331054520.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/08/National-Security/Images/Mideast_Syria_0baa3.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_404h/2010-2019/WashingtonPost/2012/03/05/Production/Daily/A-Section/Images/139060869.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Business/Images/140879311.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Sports/Images/135802009.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/08/Interactivity/Images/3_Harris_McCain.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/WashingtonPost/Content/Production/Blogs/2chambers/Images/Congress_Republicans_08309.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Interactivity/Images/140720904.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_404h/2010-2019/WashingtonPost/2012/03/04/Others/Images/2012-03-04/HOMETECH001_1330880161.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/08/Sports/Images/140941542.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_404h/WashingtonPost/Content/Blogs/early-lead/Images/Missouri_Kansas_Basketball_0bb32.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Local/Images/Jobs03_1331159761.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/05/Interactivity/Images/iStock_000010084652Small.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_404h/2010-2019/WashingtonPost/2012/03/01/Health-Environment-Science/Images/63976fdc-63d6-11e1-b51c-01d913513d63_UUIDsciencenews6.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Others/Images/2012-03-06/y%204a_1331083441.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Style/Images/kucinich--452x273.jpg?uuid=-7zdCmilEeGuP_AdkGeSuQ"]];
    [urlCache isCached:[NSURL URLWithString:@"http://img.wpdigital.net/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Food/Videos/03062012-67v/03062012-67v.jpg"]];
    [urlCache isCached:[NSURL URLWithString:@"http://www.washingtonpost.com/rf/image_606w/WashingtonPost/Content/Blogs/arts-post/Images/509485442.jpg"]];
}*/


- (IBAction)tapViewData:(id)sender
{
    if (cachePath == nil) 
    {
        cachePath = [WorkWithCache getCachePath];
        if (cachePath == nil) 
        {
            return;
        }
    }
    
    FMDatabase* cacheDatabase = [FMDatabase databaseWithPath:cachePath];
    if(![cacheDatabase open])
    {
        NSLog(@"No database");
        [cacheDatabase close];
        return;
    }
    FMResultSet *s = [cacheDatabase executeQuery:@"SELECT * FROM cfurl_cache_blob_data"];
    FMResultSet *s1 = [cacheDatabase executeQuery:@"SELECT * FROM cfurl_cache_receiver_data"];
    FMResultSet *s2 = [cacheDatabase executeQuery:@"SELECT * FROM cfurl_cache_response"];
    while ([s next] || [s1 next] || [s2 next]) 
    {
        NSLog(@"cfurl_cache_receiver_data");
        NSLog(@"column 0 %@",[s1 stringForColumnIndex:0]);
        NSLog(@"column 1 %@",[s1 stringForColumnIndex:1]);
        NSLog(@"cfurl_cache_blob_data");
        NSLog(@"column 1 %@",[s stringForColumnIndex:1]);
        NSLog(@"column 2 %@",[s stringForColumnIndex:2]);
        NSLog(@"column 3 %@",[s stringForColumnIndex:3]);
        NSLog(@"cfurl_cache_response");
        NSLog(@"column 2 %@",[s2 stringForColumnIndex:2]);
        NSLog(@"column 3 %@",[s2 stringForColumnIndex:3]);
        NSLog(@"column 4 %@",[s2 stringForColumnIndex:4]);
    }
    [cacheDatabase close];
}



@end
