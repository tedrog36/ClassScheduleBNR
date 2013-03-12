//
//  CSClass.m
//  ClassSchedule
//
//  Created by Ted Rogers on 2/11/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "CSClass.h"

@implementation CSClass

static NSDateFormatter *classDateFormatter = nil;

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setScheduleID:[[d objectForKey:@"schedule_id"] intValue]];
    [self setCurrency:[[d objectForKey:@"currency"] intValue]];
    [self setInstructor:[d objectForKey:@"instructor_one"]];
    [self setLocality:[d objectForKey:@"locality"]];
    [self setPrice:[[d objectForKey:@"price"] intValue]];
    [self setPublicPath:[d objectForKey:@"public_path"]];
    [self setRegion:[d objectForKey:@"region"]];
    [self setTitle:[d objectForKey:@"title"]];
    [self setSize:[[d objectForKey:@"total_spaces"] intValue]];
   
    NSString *classBegins = [d objectForKey:@"class_begins"];
    NSString *classEnds = [d objectForKey:@"class_ends"];
    
    if (classDateFormatter == nil)
    {
        classDateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [classDateFormatter setLocale:enUSPOSIXLocale];
        //"class_begins" = "2013-05-20 00:00:00 -0500";
        [classDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        [classDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    [self setClassBegins:[classDateFormatter dateFromString:classBegins]];
    [self setClassEnds:[classDateFormatter dateFromString:classEnds]];


    //NSLog(@"class = %@", self);
}
@end
