//
//  GenomeAuthenticator.m
//  GenomeAuthenticator
//
//  Created by Maximilian Gerlach on 2014-05-15.
//  Copyright (c) 2014 Maximilian Gerlach. All rights reserved.
//

#import "GenomeAuthenticator.h"

@interface GenomeAuthenticator ()
@property (strong, nonatomic) RACReplaySubject *authenticationSignal;
@end

NSString *const kGenomeLoginURL = @"https://genome.klick.com/home/";
NSString *const kConnectionTestURL = @"http://genome.klick.com/api/User/3438.json"; //agoldstein

@implementation GenomeAuthenticator

-(void)loadView {
	UIWebView *webview = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	webview.userInteractionEnabled = YES;
	webview.delegate = self;
	self.view = webview;
	
	//start loading already
	[webview loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:kGenomeLoginURL]]];
}


- (void) ensureReachability {
	Reachability *reach = [Reachability reachabilityForInternetConnection];
	if (! [reach isReachable]) {
		[self.authenticationSignal sendError:
		 [NSError errorWithDomain:@"Reachability" code:1 userInfo:
		  @{NSLocalizedDescriptionKey:@"No internet connection"}]];
	}
}

- (void) testCookieValidity {
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manager GET:kConnectionTestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self.authenticationSignal sendNext:@YES];
		[self.authenticationSignal sendCompleted];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self.authenticationSignal sendNext:@NO];
	}];
 }

- (RACSignal *)authenticate {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	 self.authenticationSignal = [RACReplaySubject subject];

	//make sure we're online
	[self ensureReachability];
	
	// notify subscribers whether or not they have to present this view to login
	[self testCookieValidity];
	 
	// cleanup
	@weakify(self);
	[self.authenticationSignal subscribeError:^(NSError *error) {
		@strongify(self);
		[self cleanup];
	} completed:^{
		[self cleanup];
	}];

	return self.authenticationSignal;
}

- (void) cleanup {
	[self dismissViewControllerAnimated:YES completion:NULL];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - UIWebview Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSURL *currentURL = webView.request.URL.absoluteURL;
	NSString *genomeHost = [[NSURL URLWithString:kGenomeLoginURL] host];
	
	if ([[currentURL host] isEqualToString: genomeHost]) {
		[self.authenticationSignal sendCompleted];
	}
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if ([error code] != -999) { // -999: NSURLErrorCancelled. Happens all the time
		NSLog(@"%@", [error localizedDescription]);
		[self.authenticationSignal sendError:error];
	}
}

@end
