//
//  ConnectionManager.h
//
//  Created by Ted Rogers on 2/13/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface ConnectionManager : NSObject
{
    NSURLConnection *internalConnection;
    NSMutableData *container;
}

- (id)initWithRequest:(NSURLRequest *)req;

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property (nonatomic, strong) id <NSXMLParserDelegate> xmlRootObject;
@property (nonatomic, strong) id <JSONSerializable> jsonRootObject;

- (void)start;

@end
