//
//  XFTextFlowView.m
//  XFReusedScrollViewExample
//
//  Created by Yizzuide on 2017/11/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFTextFlowView.h"

@interface XFTextFlowView ()
// 上一个最大的x位置
@property (nonatomic, assign) CGFloat maxX;
// 总个数
@property (nonatomic, assign) CGFloat rowCount;
@end

@implementation XFTextFlowView
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 迷雾遮罩层
        if (!self.maskDisabled) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIView *maskView = [[UIView alloc] init];
                maskView.backgroundColor = [UIColor whiteColor];
                maskView.frame = self.frame;
                maskView.layer.mask = ({
                    CAGradientLayer *maskLayer = [CAGradientLayer layer];
                    maskLayer.frame = maskView.bounds;
                    if (self.maskCGColors.count && self.masklocations.count) {
                        maskLayer.colors = self.maskCGColors;
                        maskLayer.locations = self.masklocations;
                    } else {
                        maskLayer.colors = @[
                                             (id)[[UIColor blackColor] CGColor],
                                             (id)[[UIColor clearColor] CGColor],
                                             (id)[[UIColor clearColor] CGColor],
                                             (id)[[UIColor blackColor] CGColor],
                                             ];
                        maskLayer.locations = @[@0.0, @0.33, @0.66, @1.0];
                    }
                    maskLayer.startPoint = CGPointMake(0.0, 0.0);
                    maskLayer.endPoint = CGPointMake(1.0, 0.0);
                    maskLayer;
                });
                [self.superview addSubview:maskView];
                maskView.userInteractionEnabled = NO;
            });
        }
        
    }
    return self;
}

- (void)layoutBefore
{
    self.maxX = self.marginLeftForContent;
    self.rowCount = [self.dataSource simpleFlowView:self numberOfRowsInSection:0];
}

- (CGRect)layoutCellAtRow:(NSInteger)row ofSection:(NSInteger)section withCellHeight:(CGFloat)cellHeight
{
    CGFloat cellH = cellHeight;
    CGFloat cellW = [self cellWidthWithIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    CGFloat cellX = self.maxX;
    CGFloat cellY = 0;
    self.maxX = cellX + cellW + (row == self.rowCount - 1 ? 0 : self.marginColumnForCell);
    return CGRectMake(cellX, cellY, cellW, cellH);
}

- (void)layoutAfter
{
    self.contentSize = CGSizeMake(self.maxX + self.marginRightForContent, self.bounds.size.height);
}

- (CGFloat)cellWidthWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(textFlowView:widthForRowAtIndexPath:)]) {
        return [self.delegate textFlowView:self widthForRowAtIndexPath:indexPath];
    }
    return XFSimpleFlowViewDefaultCellWH;
}

- (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size.height;
}
@end
