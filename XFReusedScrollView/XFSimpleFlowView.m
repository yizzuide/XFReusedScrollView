//
//  XFSimpleFlowView.m
//  AdjustStudentSeat
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSimpleFlowView.h"

#define XFSimpleFlowViewDefaultCellWH 100
#define XFSimpleFlowViewDefaultSectionCount 1

@interface XFSimpleFlowView ()
/**
 *  记录每组的cell数量
 */
@property (nonatomic, strong) NSMutableDictionary *rowsOfSection;
@end

@implementation XFSimpleFlowView
@dynamic delegate;

- (NSMutableDictionary *)rowsOfSection
{
    if (_rowsOfSection == nil) {
        _rowsOfSection = [NSMutableDictionary dictionary];
    }
    return _rowsOfSection;
}

#pragma mark - 公有方法
- (void)layoutBefore{}

- (void)layoutAfter{}

- (void)reloadData
{
    [super reloadData];
    // 清空记录
    [self.rowsOfSection removeAllObjects];
    
    // 调用布局初始化方法
    [self layoutBefore];
    
    // 计算行列数
    NSUInteger sectionCount = [self numberOfSections];
    for (int i = 0; i<sectionCount; i++) {
        NSUInteger rowCount = [self.dataSource simpleFlowView:self numberOfRowsInSection:i];
        self.rowsOfSection[@(i)] = @(rowCount);
        
        for (int j = 0; j<rowCount; j++) {
            // cell大小
            CGFloat cellHeight = [self cellHeightWithIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            
            // 计算Frame
            CGRect cellFrame = [self layoutCellAtRow:j ofSection:i withCellHeight:cellHeight];
            [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        }
    }
    // 设置内容大小
    CGRect lastFrame = [[self.cellFrames lastObject] CGRectValue];
    self.contentSize = CGSizeMake(CGRectGetMaxX(lastFrame) + self.marginRightForContent,
                                  CGRectGetMaxY(lastFrame)+ self.marginBottomForContent);
    // 调用布局完成方法
    [self layoutAfter];
}

- (id<XFReusedCellDelegate>)cellAtIndex:(NSInteger)index
{
    return [self.dataSource simpleFlowView:self cellForRowAtIndexPath:[self indexPathFromIndex:index]];
}

#pragma mark - 勾子方法
- (CGRect)layoutCellAtRow:(NSInteger)row ofSection:(NSInteger)section withCellHeight:(CGFloat)cellHeight
{
    CGFloat cellWH = cellHeight;
    CGFloat cellX = self.marginLeftForContent + row * (self.marginColumnForCell + cellWH);
    CGFloat cellY = self.marginTopForContent + section * (self.marginRowForCell + cellWH);
    return CGRectMake(cellX, cellY, cellWH, cellWH);
}

#pragma mark - 事件方法
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(simpleFlowView:didSelectRowAtIndexPath:)]) return;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        UIView *cell = obj;
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.delegate simpleFlowView:self
              didSelectRowAtIndexPath:[self indexPathFromIndex:[selectIndex integerValue]]];
    }
}

#pragma mark - 私有方法
// 从index转为indexPath
- (NSIndexPath *)indexPathFromIndex:(NSInteger)index
{
    // 根据全局index下标组装indexPath
    NSInteger selectedSection;
    NSInteger selectedRow;
    NSInteger left = index;
    NSInteger sectionCount = self.rowsOfSection.allKeys.count;
    for (int i = 0; i<sectionCount; i++) {
        NSInteger rowCount = [self.rowsOfSection[@(i)] integerValue];
        NSInteger offset = left - rowCount;
        if(offset > 0){
            left = offset;
        }else if(offset == 0){
            selectedSection = i + 1;
            selectedRow = 0;
            break;
        }else{
            selectedSection = i;
            selectedRow = left;
            break;
        }
    }
    return [NSIndexPath indexPathForRow:selectedRow inSection:selectedSection];
}
// 组数
- (NSInteger)numberOfSections
{
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInSimpleFlowView:)]) {
        return [self.dataSource numberOfSectionsInSimpleFlowView:self];
    }
    return XFSimpleFlowViewDefaultSectionCount;
}
// cell高度
- (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(simpleFlowView:heightForRowAtIndexPath:)]) {
        return [self.delegate simpleFlowView:self heightForRowAtIndexPath:indexPath];
    }
    return XFSimpleFlowViewDefaultCellWH;
}


@end
