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
        NSData * urlData = [cache getCachedFile:[NSURL URLWithString:urlString]];
        [listWebView loadData:urlData MIMEType:@"text/html" textEncodingName:@"UTF8" baseURL:nil];
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
        return 21;
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
