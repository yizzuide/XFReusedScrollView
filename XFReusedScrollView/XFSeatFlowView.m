//
//  XFStudentSeatView.m
//  AdjustStudentSeat
//
//  Created by 付星 on 16/9/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSeatFlowView.h"

@implementation XFSeatFlowView

// 覆盖父类默认横向布局实现，这里类似座位排列
- (CGRect)layoutCellAtRow:(NSInteger)row ofSection:(NSInteger)section withCellHeight:(CGFloat)cellHeight
{
    CGFloat cellWH = cellHeight;
    CGFloat cellX = self.marginLeftForContent + section * (self.marginColumnForCell + cellWH);
    CGFloat cellY = self.marginTopForContent + row * (self.marginRowForCell + cellWH);
    return CGRectMake(cellX, cellY, cellWH, cellWH);
}
@end
