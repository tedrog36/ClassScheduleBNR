//
//  CSClassRegions.m
//  ClassSchedule
//
//  Created by Ted Rogers on 2/16/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "CSClassRegions.h"
#import "CSClassRegion.h"

@implementation CSClassRegions

- (id)init
{
    self = [super init];
    if (self)
    {
        // create the array of CSClassRegion
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)readFromJSONDictionary:(NSDictionary *)d
{
    // top-level dictionary is the regions
    for (NSString *region in d)
    {
        // this is a dictionary of classes for the region
        NSDictionary *classesDict = [d objectForKey:region];
        CSClassRegion *classRegion = [[CSClassRegion alloc] initWithName:region];
        [classRegion readFromJSONDictionary:classesDict];
        [_items addObject:classRegion];
    }
}

@end
