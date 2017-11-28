//
//  XFMenuCell.m
//  XFReusedScrollViewExample
//
//  Created by Yizzuide on 2017/11/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFMenuCell.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation XFMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        self.backgroundColor = randomColor;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    self.titleLabel.font = [UIFont systemFontOfSize:selected ? 18.f : 15.f];
    [self setTitleColor:selected ? [UIColor orangeColor] : [UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setText:(NSString *)text {
    [self setTitle:text forState:UIControlStateNormal];
}
@end
