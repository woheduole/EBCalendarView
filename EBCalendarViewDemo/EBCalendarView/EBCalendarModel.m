//
//  EBCalendarModel.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/25.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "EBCalendarModel.h"
#import "NSDate+EBAdd.h"

@implementation EBCalendarModel

- (instancetype)init {
    if (self = [super init]) {
        _year = 0;
        _month = 0;
        _day = 0;
    }
    return self;
}

- (NSDate*)date {
    if (_year == 0 || _month == 0 || _day == 0) {
        return nil;
    }
    return [NSDate dateWithString:[NSString stringWithFormat:@"%zd-%zd-%zd"
                            , _year
                            , _month
                            , _day] format:@"yyyy-MM-dd"];
}
@end
