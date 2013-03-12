//
//  CSClass.h
//  ClassSchedule
//
//  Created by Ted Rogers on 2/11/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface CSClass : NSObject <JSONSerializable>
{
}
@property (nonatomic) int scheduleID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *classBegins;
@property (nonatomic, strong) NSDate *classEnds;
@property (nonatomic, strong) NSString *locality;
@property (nonatomic) int price;
@property (nonatomic) int currency;
@property (nonatomic, strong) NSString *instructor;
@property (nonatomic, strong) NSString *region;
@property (nonatomic) int size;
@property (nonatomic, strong) NSString *publicPath;

@end
