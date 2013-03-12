//
//  CSScheduleStore.m
//
//  Created by Ted Rogers on 2/13/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "CSScheduleStore.h"
#import "ConnectionManager.h"

@implementation CSScheduleStore

+ (CSScheduleStore *)sharedStore
{
    static CSScheduleStore *scheduleStore = nil;
    if (!scheduleStore)
        scheduleStore = [[CSScheduleStore alloc] init];
    return scheduleStore;
}

- (void)fetchBNRSchedule:(id<JSONSerializable>)rootObject withCompletion:(void (^)(id, NSError *))block
{
    // prepare a request URL, including the argument from the controller
    NSString *requestString = [NSString stringWithFormat:@"http://bignerdranch.com/json/schedule"];
    NSURL *url = [NSURL URLWithString:requestString];
    
    // setup the connection as normal
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //create the connection "actor" objecdt taht will transfer dat from the server
    ConnectionManager *connection = [[ConnectionManager alloc] initWithRequest:request];
    
    // when the connection completes, this block from the controller will be called
    [connection setCompletionBlock:block];
    
    // let the empty channel object parse the returning data from the web service
    [connection setJsonRootObject:rootObject];
    
    // begin the connection
    [connection start];
}

@end
