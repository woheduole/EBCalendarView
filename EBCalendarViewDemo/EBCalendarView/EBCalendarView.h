//
//  EBCalendarView.h
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/25.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EBCalendarViewDelegate;

@interface EBCalendarView : UIView
// 默认-1不做限制
@property (nonatomic, assign) NSInteger maxLastMonths;
// 默认-1不做限制
@property (nonatomic, assign) NSInteger maxNextMonths;

@property (nonatomic, weak) id<EBCalendarViewDelegate> delegate;
@end

@protocol EBCalendarViewDelegate <NSObject>
@optional
- (void)calendarView:(EBCalendarView*)calendarView didSelectedDate:(NSDate*)date;
@end
