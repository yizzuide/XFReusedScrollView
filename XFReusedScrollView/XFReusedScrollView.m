//
//  XFReusedScrollView.m
//  XFReusedScrollView
//
//  Created by 付星 on 16/9/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFReusedScrollView.h"

#define XFReusedScrollViewDefaultMargin 8

@implementation XFReusedScrollView

@dynamic delegate;

#pragma mark - 初始化
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

#pragma mark - 生命周期方法

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!self.disableDispathTouchEvent) {
            // 禁止延迟150m对子View的事件派发
            self.delaysContentTouches = NO;
        }
        
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 向数据源索要对应位置的cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i = 0; i<numberOfCells; i++) {
        // 取出i位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        // 优先从字典中取出i位置的cell
        UIView *cell = (UIView *)self.displayingCells[@(i)];
        
        // 判断i位置对应的frame在不在屏幕上（能否看见）
        if ([self isInScreen:cellFrame]) { // 在屏幕上
            if (cell == nil) {
                cell = (UIView *)[self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                // 存放到字典中
                self.displayingCells[@(i)] = cell;
            }
        } else {  // 不在屏幕上
            if (cell) {
                // 从scrollView和字典中移除
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                // 存放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}

#pragma mark - 事件处理
- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    if (!self.disableDispathTouchEvent) {
        // 返回YES使UIScrollView把Touch事件传给子View
        return YES;
    }
    return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if (!self.disableDispathTouchEvent) {
        // 返回YES使UIScrollView在滚动时，把子View事件处理接管过来，如果返回NO就无法滚动
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

#pragma mark - 公有方法
- (void)reloadData
{
    [self clearDirty];
}


- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    __block id<XFReusedCellDelegate> reusableCell = nil;
    
    [self.reusableCells enumerateObjectsUsingBlock:^(id<XFReusedCellDelegate> cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    
    if (reusableCell) { // 从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    // 返回可利用的cell
    return reusableCell;
}

#pragma mark - 勾子方法
- (id<XFReusedCellDelegate>)cellAtIndex:(NSInteger)index
{
    return nil;
}

- (CGFloat)marginTopForContent {
    return [self marginForType:XFReusedScrollViewMarginTypeTop];
}

- (CGFloat)marginBottomForContent {
    return [self marginForType:XFReusedScrollViewMarginTypeBottom];
}

- (CGFloat)marginLeftForContent {
    return [self marginForType:XFReusedScrollViewMarginTypeLeft];
}

- (CGFloat)marginRightForContent {
    return [self marginForType:XFReusedScrollViewMarginTypeRight];
}

- (CGFloat)marginColumnForCell {
    return [self marginForType:XFReusedScrollViewMarginTypeColumn];
}

- (CGFloat)marginRowForCell {
    return [self marginForType:XFReusedScrollViewMarginTypeRow];
}


#pragma mark - 私有方法
/**
 *  间距
 */
- (CGFloat)marginForType:(XFReusedScrollViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(reusedScrollView:marginForType:)]) {
        return [self.delegate reusedScrollView:self marginForType:type];
    } else {
        return XFReusedScrollViewDefaultMargin;
    }
}

/**
 *  判断一个frame有无显示在屏幕上
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height) &&
    (CGRectGetMaxX(frame) > self.contentOffset.x) &&
    (CGRectGetMinX(frame) < self.contentOffset.x + self.bounds.size.width);
}
/**
 *  清空之前的所有数据
 */
- (void)clearDirty
{
    // 移除正在正在显示cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
}

@end
