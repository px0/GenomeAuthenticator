//
//  GenomeAuthenticator.h
//  GenomeAuthenticator
//
//  Created by Maximilian Gerlach on 2014-05-15.
//  Copyright (c) 2014 Maximilian Gerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;


@interface GenomeAuthenticator : UIViewController <UIWebViewDelegate>
/**
 * Tries to authenticate with Genome. If the authentication is successful, the returned signal 
 * is @YES, otherwise it is @NO. If the result is @NO, present the view controller to log in.
 * Example:
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
 * @return A RACSignal which will resolve to @YES if the authentication is successful and @NO if
 * if this ViewController needs to be presented in order to let the user log in
 */
- (RACSignal*) authenticate;
@end
