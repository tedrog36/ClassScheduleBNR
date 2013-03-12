//
//  JSONSerializable.h
//  ClassSchedule
//
//  Created by Ted Rogers on 2/13/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void)readFromJSONDictionary:(NSDictionary *)d;

@end
