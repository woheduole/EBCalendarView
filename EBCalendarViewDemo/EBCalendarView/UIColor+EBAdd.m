//
//  UIColor+Hex.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/26.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "UIColor+EBAdd.h"

@implementation UIColor (EBAdd)
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end
