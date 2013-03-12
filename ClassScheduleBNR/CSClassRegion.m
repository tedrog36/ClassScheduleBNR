//
//  CSClassRegion.m
//  ClassSchedule
//
//  Created by Ted Rogers on 2/11/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "CSClassRegion.h"
#import "CSClass.h"

@implementation CSClassRegion

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        [self setName:name];
        // create the array of CSClass
        _items = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (id) createNamedItem:(NSString *)name withDictionary:(NSDictionary *)entry
{
    CSClass *i = [[CSClass alloc] init];
    // pass the entry dictionary to the time so it can grab its ivars
    [i readFromJSONDictionary:entry];    
    [_items addObject:i];    
    return i;
}

- (void)readFromJSONDictionary:(NSDictionary *)classesDict
{
    for (NSString *class in classesDict)
    {
        // this is the dictionary of values/members for the class
        NSDictionary *classDict = [classesDict objectForKey:class];
        [self createNamedItem:class withDictionary:classDict];
    }
}
@end
