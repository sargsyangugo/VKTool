//
//  ViewController.m
//  VKTool
//
//  Created by Admin on 5/9/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "ViewController.h"
#import "GTMHTTPFetcher.h"
#import "HTMLDocument.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://google.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher* fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher shouldFetchInBackground];
    [fetcher beginFetchWithDelegate:self
                  didFinishSelector:@selector(myFetcher:finishedWithData:error:)];
    
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error {
    if (error != nil) {
        // failed; either an NSURLConnection error occurred, or the server returned
        // a status value of at least 300
        //
        // the NSError domain string for server status errors is kGTMHTTPFetcherStatusDomain
        
        NSLog(@"Error: %@ Code %i", [error localizedDescription], [error code]);
        
    } else {
        // fetch succeeded
        //NSString *data = [[[NSString alloc] initWithData:retrievedData encoding:NSUTF8StringEncoding] autorelease];
        
        HTMLDocument* htmlDoc = [HTMLDocument documentWithData:retrievedData error:nil];
        NSLog(@"Document: %@", [htmlDoc description]);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
