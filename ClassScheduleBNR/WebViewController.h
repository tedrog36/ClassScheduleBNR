//
//  WebViewController.h
//  ClassSchedule
//
//  Created by Ted Rogers on 3/4/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

- (id)initWithFrame:(CGRect)frame withUrlString:(NSString*)urlString;

@end
