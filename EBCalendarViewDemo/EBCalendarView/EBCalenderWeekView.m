//
//  EBCalenderWeekView.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/5/2.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "EBCalenderWeekView.h"
#import "UIColor+EBAdd.h"
@implementation EBCalenderWeekView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self createWeekView];
}

- (void)setWeeks:(NSArray *)weeks {
    _weeks = weeks;
    [self createWeekView];
}

- (void)createWeekView {
    CGFloat viewWidth = CGRectGetWidth(self.bounds)
    , viewHeight = CGRectGetHeight(self.bounds);
    if (_weeks.count == 0 || viewHeight == 0) return;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger weekCount = _weeks.count;
    CGFloat weekWidth = viewWidth / weekCount;
    for (int n = 0; n < weekCount; n ++ ) {
        NSString *week =  _weeks[n];
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(weekWidth * n, 0, weekWidth, viewHeight)];
        weekLabel.font = [UIFont systemFontOfSize:14];
        weekLabel.textColor = [UIColor colorWithHexString:@"333333"];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.text = week;
        [self addSubview:weekLabel];
    }
}
@end
