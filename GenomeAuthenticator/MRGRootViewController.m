//
//  MRGRootViewController.m
//  GenomeAuthenticator
//
//  Created by Maximilian Gerlach on 2014-05-17.
//  Copyright (c) 2014 Maximilian Gerlach. All rights reserved.
//

#import "MRGRootViewController.h"
#import "GenomeAuthenticator.h"

@interface MRGRootViewController ()
@property (strong, nonatomic) GenomeAuthenticator *genomeAuthenticator;
@property (strong, nonatomic) UIWebView *webview ;

@end

@implementation MRGRootViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL)animated];
	
	NSLog(@"Logging in!");
	
	self.genomeAuthenticator = [[GenomeAuthenticator alloc] init];
	@weakify(self);
	[[_genomeAuthenticator authenticate] subscribeNext:^(id authStatus) {
		BOOL authenticationSuccessful = [authStatus boolValue];
		if(! authenticationSuccessful) {
			@strongify(self);
			[self presentViewController:self.genomeAuthenticator animated:YES completion:NULL];
		}
	} error:^(NSError *error) {
		NSLog(@"An error has occured: %@", [error localizedDescription]);
	} completed:^{
		NSLog(@"You are now authenticated!");
	}];
}


@end
