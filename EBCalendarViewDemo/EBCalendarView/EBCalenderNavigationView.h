//
//  EBCalenderNavigationView.h
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/5/3.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EBCalenderNavigationViewDelegate;

@interface EBCalenderNavigationView : UIView
@property (nonatomic, copy) NSString *showDate;
@property (nonatomic, weak) id<EBCalenderNavigationViewDelegate> delegate;
@end


@protocol EBCalenderNavigationViewDelegate <NSObject>
- (void)calenderNavigationViewDidChangeMonth:(EBCalenderNavigationView *)calenderNavigationView isNextMonth:(BOOL)isNextMonth;
@end

