# EBCalendarView
CalendarView for iOS


# 调用示例

```
    EBCalendarView *calendarView = [[EBCalendarView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 0)];
    calendarView.delegate = self;
    //calendarView.maxLastMonths = 0;  
    //calendarView.maxNextMonths = 0;
    [self.view addSubview:calendarView];
```

```
- (void)calendarView:(EBCalendarView*)calendarView didSelectedDate:(NSDate*)date {
    NSLog(@"选中日期:%@", [date stringWithFormat:@"yyyy-MM-dd"]);
}
```
![](https://upload-images.jianshu.io/upload_images/2107229-f0df4c46723031be.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/360)

[博客地址:https://www.jianshu.com/p/85bbdd0f8251](https://www.jianshu.com/p/85bbdd0f8251)
