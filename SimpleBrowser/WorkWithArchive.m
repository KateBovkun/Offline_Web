//
//  WorkWithArchive.m
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/29/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import "WorkWithArchive.h"
#import "ASIHTTPRequest.h"
#import "PageLoader.h"
#import "ZKDefs.h"

@implementation WorkWithArchive

+(void)extractFilesWithData:(NSMutableData*) data
{
    ZKDataArchive * archive = [ZKDataArchive archiveWithArchiveData:data];
    [archive inflateAll];
    NSLog(@"files in archive %d", [archive.inflatedFiles count]);
    NSString * localfile = @"";//[[NSString alloc] initWithString:@"file:/"];
    NSString *tmpDir =  [[NSString alloc] initWithFormat:@"%@%@",localfile,[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    for (NSDictionary* archiveData in archive.inflatedFiles) 
    {
       // NSLog(@"%@",[archiveData valueForKey:ZKPathKey]);
        NSString * urlString = [[[NSString alloc] initWithFormat:@"%@/%@", tmpDir, [archiveData valueForKey:ZKPathKey]] autorelease];
       // NSLog(@"%@", urlString);
        [[NSUserDefaults standardUserDefaults] setValue:urlString forKey:[archiveData valueForKey:ZKPathKey]];
        
        [[NSFileManager defaultManager] createFileAtPath:urlString contents:[archiveData objectForKey:ZKFileDataKey] attributes:[archiveData objectForKey:ZKFileAttributesKey]];
       // [data writeToFile:data.description atomically:YES];
        
        PageLoader * pageLoader = [[[PageLoader alloc] init] autorelease];
        [pageLoader requestPageWithURLString:urlString];
    }
}

/*- (NSInteger)tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section {
	return [self.archive.inflatedFiles count];
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	NSDictionary *entry = [self.archive.inflatedFiles objectAtIndex:[indexPath row]];
	cell.textLabel.text = [entry objectForKey:ZKPathKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
	NSUInteger row = [indexPath row];
	NSDictionary *fileDict = [self.archive.inflatedFiles objectAtIndex:row];
	NSData *fileData = [fileDict objectForKey:ZKFileDataKey];
	NSString *fileName = [fileDict objectForKey:ZKPathKey];
	
	NSString *ext = [fileName pathExtension];
	if ([ext isEqualToString:@"txt"]) {
		[self.textView setText:[[[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding] autorelease]];
		self.nextViewController.view = self.textView;
	} else if ([ext isEqualToString:@"png"]) {
		[self.imageView setImage:[UIImage imageWithData:fileData]];
		self.nextViewController.view = self.imageView;
	} else {
		[self.textView setText:@"Only txt and PNG files are supported"];
		self.nextViewController.view = self.textView;
	}
	
	[self.navigationController pushViewController:nextViewController animated:YES];
}
*/

@end
