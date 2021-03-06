//
//  NSTimerCellTableViewCell.m
//  TestNSTimer
//
//  Created by wyz on 15/11/21.
//  Copyright © 2015年 wyz. All rights reserved.
//

#import "NSTimerCellTableViewCell.h"
#import "HFTools.h"
@interface NSTimerCellTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *minius;
@property (weak, nonatomic) IBOutlet UILabel *secend;
@property (weak, nonatomic) IBOutlet UILabel *ss;

@end


@implementation NSTimerCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)setEndTime:(NSString *)endTime{
    _endTime  =endTime;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTime:) userInfo:nil repeats:YES];
    [self refreshTime:time];
    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
}

- (void)refreshTime:(NSTimer *)tm
{
    NSDate *currentDate =[NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit  unit = NSDayCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  | NSCalendarUnitSecond;
    NSDateComponents *commponent = [calendar components:unit fromDate:currentDate toDate:[HFTools getDateWithString:_endTime ] options:NSCalendarWrapComponents];
    
    
    NSDate *dt = [[HFTools getDateWithString:_endTime] earlierDate:currentDate];
    
//    self.getPrimeRate.enabled =YES;
    
    if([dt isEqualToDate:[HFTools getDateWithString:_endTime ]])
    {
        [tm invalidate];
//        self.getPrimeRate.enabled = NO;
        
        _day.text = @"0天";
        _hours.text = @"00时" ;
        _minius.text = @"00分" ;
        _secend.text = @"00秒" ;
        
    }else
    {
        _day.text = [NSString stringWithFormat:@"%zd天" , commponent.day];
        _hours.text = [NSString stringWithFormat:@"%02zd时" , commponent.hour];
        _minius.text = [NSString stringWithFormat:@"%02zd分" , commponent.minute];
        _secend.text = [NSString stringWithFormat:@"%02zd秒" , commponent.second];
//        _ss.text= [NSString stringWithFormat:@"%03zd" , commponent.nanosecond];

    }
}

@end
