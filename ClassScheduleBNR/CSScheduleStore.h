//
//  CSClassRegion.h
//
//  Created by Ted Rogers on 2/13/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@class CSClassRegion;

@interface CSScheduleStore : NSObject

+ (CSScheduleStore *)sharedStore;

- (void)fetchBNRSchedule:(id <JSONSerializable>)rootObject withCompletion:(void (^)(id, NSError *))block;

@end
