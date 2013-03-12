//
//  ConnectionManager.m
//
//  Created by Ted Rogers on 2/13/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "ConnectionManager.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation ConnectionManager

 - (id)initWithRequest:(NSURLRequest *)req
{
    self = [super init];
    if (self)
    {
        [self setRequest:req];
    }
    return self;
}

- (void)start
{
    // initialize container for data collected from NSURLConnection
    container = [[NSMutableData alloc] init];
    
    // spawn connection
    internalConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:YES];
    
    // if this is the first connection, create the array
    if (!sharedConnectionList)
        sharedConnectionList = [[NSMutableArray alloc] init];
    
    // add the connection to the array so it doesn't get destroyed
    [sharedConnectionList addObject:internalConnection];
}

// NSURLConnectionDelegate delegate implementation
- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // add the incoming chunk of data to the container we are keeping
    // the data always comes in the correct order
    //    NSLog(@"Received %d bytes", [data length]);
    [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    // we are just checking to make sure we are getting the XML
    //NSString *xmlCheck = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    // NSLog(@"xmlCheck == %@", xmlCheck);
    // create the parser object with the data received from the web service
    id rootObject = nil;
    if ([self xmlRootObject])
    {
        // create a parser with the incoming data and let the root object parse
        // its contents
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:container];
    
        // give it a delegate
        [parser setDelegate:[self xmlRootObject]];
    
        // tell it to start parsing - the document will be parsed and
        // the delegate of NSXMLParser will get all of its delegate messages
        // sent to it before this line finishes executing - it is a blocking call
        [parser parse];
        
        rootObject = [self xmlRootObject];
    }
    else
    if ([self jsonRootObject])
    {
        // turn JSON into the basic model objects
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil];
        
        // have the root object construct itself from the basic model objects
        [[self jsonRootObject] readFromJSONDictionary:d];
        
        rootObject = [self jsonRootObject];
    }
    
    // then pass the root object to the completion block - remember,
    // this is the block that the controller supplied
    if ([self completionBlock])
        [self completionBlock](rootObject, nil);
    
    // now destroy this connection
    [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
    if ([self completionBlock])
        [self completionBlock]([self xmlRootObject], error);

    // now destroy this connection
    [sharedConnectionList removeObject:self];
}


@end
