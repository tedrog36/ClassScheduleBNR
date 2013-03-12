//
//  CSClassRegions.h
//  ClassSchedule
//
//  Created by Ted Rogers on 2/16/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface CSClassRegions : NSObject <JSONSerializable>
{
    
}
@property (nonatomic, readonly, strong) NSMutableArray *items;

@end
