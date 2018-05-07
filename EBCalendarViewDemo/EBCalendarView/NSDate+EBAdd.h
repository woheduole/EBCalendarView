//
//  NSDate+EBAdd.h
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/28.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (EBAdd)
// 该方法来源自YYKit
- (NSInteger)year;

// 该方法来源自YYKit
- (NSInteger)month;

// 该方法来源自YYKit
- (NSInteger)day;

// 该方法来源自YYKit
- (NSInteger)weekday;

// 该方法来源自YYKit
- (BOOL)isToday;

// 当前月有多少天
- (NSUInteger)numberOfDaysInMonth;

// 该方法来源自YYKit
- (NSString *)stringWithFormat:(NSString *)format;

// 该方法来源自YYKit
- (NSDate *)dateByAddingMonths:(NSInteger)months;

// 该方法来源自YYKit
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

@end
