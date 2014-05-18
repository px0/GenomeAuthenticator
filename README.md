GenomeAuthenticator
===================

Code Sample:
```
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
```
