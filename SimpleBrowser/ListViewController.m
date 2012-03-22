//
//  ListViewController.m
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/22/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

- (void) initDataArray;

@end

@implementation ListViewController

@synthesize delegate;
@synthesize cache;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDataArray];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* urlString = [tableData objectAtIndex:indexPath.row];
    NSLog(@"%@", urlString);
    if ([cache isCached:[NSURL URLWithString:urlString]]) 
    {
        //NSData * urlData = [cache getCachedFile:[NSURL URLWithString:urlString]];
        [listWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:100]];
        //[listWebView loadData:urlData MIMEType:@"text/html" textEncodingName:@"UTF8" baseURL:nil];
    }

}

-(IBAction)tapBackButton:(id)sender
{
    [self.view setHidden:YES];
    [self.view removeFromSuperview];
    [self.delegate viewUnload];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) 
    {
        return 41;
    }
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) 
    {
        return nil;
    }
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.textLabel.text = (NSString*)[tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void) initDataArray
{
    tableData = [[[NSArray alloc] initWithObjects:
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-1.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-2.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-3.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-4.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-5.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-6.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-7.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-8.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-9.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-10.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-11.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-12.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-13.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-14.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-15.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-16.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-17.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-18.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-19.html",
        @"http://ddarchive.net/wp-projects/ipad2/html5-test/articles/article-20.html",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Others/Images/2012-03-06/v%201_1331040840.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Production/Digital/homepage/Images/509058895.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Local/Images/MONITOR006_1331054520.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/08/National-Security/Images/Mideast_Syria_0baa3.jpg",
        @"http://www.washingtonpost.com/rf/image_404h/2010-2019/WashingtonPost/2012/03/05/Production/Daily/A-Section/Images/139060869.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Business/Images/140879311.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Sports/Images/135802009.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/08/Interactivity/Images/3_Harris_McCain.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/WashingtonPost/Content/Production/Blogs/2chambers/Images/Congress_Republicans_08309.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Interactivity/Images/140720904.jpg",
        @"http://www.washingtonpost.com/rf/image_404h/2010-2019/WashingtonPost/2012/03/04/Others/Images/2012-03-04/HOMETECH001_1330880161.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/08/Sports/Images/140941542.jpg",
        @"http://www.washingtonpost.com/rf/image_404h/WashingtonPost/Content/Blogs/early-lead/Images/Missouri_Kansas_Basketball_0bb32.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Local/Images/Jobs03_1331159761.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/05/Interactivity/Images/iStock_000010084652Small.jpg",
        @"http://www.washingtonpost.com/rf/image_404h/2010-2019/WashingtonPost/2012/03/01/Health-Environment-Science/Images/63976fdc-63d6-11e1-b51c-01d913513d63_UUIDsciencenews6.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Others/Images/2012-03-06/y%204a_1331083441.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/2010-2019/WashingtonPost/2012/03/07/Style/Images/kucinich--452x273.jpg?uuid=-7zdCmilEeGuP_AdkGeSuQ",
        @"http://img.wpdigital.net/rf/image_606w/2010-2019/WashingtonPost/2012/03/06/Food/Videos/03062012-67v/03062012-67v.jpg",
        @"http://www.washingtonpost.com/rf/image_606w/WashingtonPost/Content/Blogs/arts-post/Images/509485442.jpg",
     nil] retain];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)dealloc
{
    [tableData release];
    [super dealloc];
}

@end
