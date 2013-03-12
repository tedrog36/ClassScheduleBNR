//
//  CSClassRegion.h
//  ClassSchedule
//
//  Created by Ted Rogers on 2/11/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface CSClassRegion : NSObject <JSONSerializable>
{
}

- (id)initWithName:(NSString *)name;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly, strong) NSMutableArray *items;

@end
