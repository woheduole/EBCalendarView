//
//  EBCalendarModel.h
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/25.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBCalendarModel : NSObject
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign, getter=isToday) BOOL today;
@property (nonatomic, strong, readonly) NSDate *date;
@end
