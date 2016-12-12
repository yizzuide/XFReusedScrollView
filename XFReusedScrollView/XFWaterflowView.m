//
//  XFWaterflowView.m
//  XFReusedScrollView
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWaterflowView.h"

#define XFWaterflowViewDefaultNumberOfColumns 3

@interface XFWaterflowView ()
// 总列数
@property (nonatomic, assign) NSInteger columns;
// cell宽度
@property (nonatomic, assign) NSInteger cellW;

// 存放所有列的最大Y值
@property (nonatomic, strong) NSMutableArray *maxYOfColumns;
@end

@implementation XFWaterflowView
@dynamic dataSource;

// 布局前初始化一些变量
- (void)layoutBefore
{
    self.columns = [self numberOfColumns];
    self.maxYOfColumns = [NSMutableArray arrayWithCapacity:self.columns];
    for (int i = 0; i<self.columns; i++) {
        self.maxYOfColumns[i] = @0;
    }
    self.cellW = [self cellWidth];
}

- (CGRect)layoutCellAtRow:(NSInteger)row ofSection:(NSInteger)section withCellHeight:(CGFloat)cellHeight
{
    // cell处在第几列(最短的一列)
    NSInteger cellColumn = 0;
    // cell所处那列的最大Y值(最短那一列的最大Y值)
    CGFloat maxYOfCellColumn = [self maxYAtIndex:cellColumn];
    // 求出最短的一列
    for (int j = 1; j<self.columns; j++) {
        if ([self maxYAtIndex:j] < maxYOfCellColumn) {
            cellColumn = j;
            maxYOfCellColumn = [self maxYAtIndex:j];
        }
    }
    
    // cell的位置
    CGFloat cellX = self.marginLeftForContent + cellColumn * (self.cellW + self.marginColumnForCell);
    CGFloat cellY = 0;
    if (maxYOfCellColumn == 0.0) { // 首行
        cellY = self.marginTopForContent;
    } else {
        cellY = maxYOfCellColumn + self.marginRowForCell;
    }
    
    CGRect cellFrame = CGRectMake(cellX, cellY, self.cellW, cellHeight);
    // 更新最短那一列的最大Y值
    self.maxYOfColumns[cellColumn] = @(CGRectGetMaxY(cellFrame));
    
    // 添加frame到数组中
    return cellFrame;
    
}

// 布局后调用，父类默认使用最后一个元素来设置contentSize，但瀑布流有并不是最一个cell在最在Y位置，所以要重新计算
- (void)layoutAfter
{
    // 计算contentSize
    CGFloat contentH = [self maxYAtIndex:0];
    for (int j = 1; j<self.columns; j++) {
        if ([self maxYAtIndex:j] > contentH) {
            contentH = [self maxYAtIndex:j];
        }
    }
    contentH += self.marginBottomForContent;
    self.contentSize = CGSizeMake(0, contentH);
}


#pragma mark - 公有方法
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth
{
    return (self.bounds.size.width + 1 - self.marginLeftForContent - self.marginRightForContent - (self.columns - 1) * self.marginColumnForCell) / self.columns;
}

#pragma mark - 私有方法
- (NSInteger)numberOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dataSource numberOfColumnsInWaterflowView:self];
    } else {
        return XFWaterflowViewDefaultNumberOfColumns;
    }
}

- (CGFloat)maxYAtIndex:(NSInteger)index
{
    return [self.maxYOfColumns[index] floatValue];
}

@end
