//
//  XFStudentSeatCell.m
//  AdjustStudentSeat
//
//  Created by 付星 on 16/9/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFCell.h"

@interface XFCell ()

@property (nonatomic, strong) UILabel *titleLable;
@end

@implementation XFCell

- (UILabel *)titleLable
{
    if (_titleLable == nil) {
        UILabel *titleLable  = [[UILabel alloc] init];
        titleLable.frame = CGRectMake(0, 0, 100, 20);
        [self addSubview:titleLable];
        _titleLable = titleLable;
    }
    return _titleLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [self addSubview:add];
    }
    return self;
}

- (void)setText:(NSString *)text {
    self.titleLable.text = text;
}



@end
