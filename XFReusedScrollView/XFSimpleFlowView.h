//
//  XFSimpleFlowView.h
//  XFReusedScrollView
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFReusedScrollView.h"

typedef enum {
    // ScrollView上下左右间距
    XFSimpleFlowViewMarginTypeTop,
    XFSimpleFlowViewMarginTypeBottom,
    XFSimpleFlowViewMarginTypeLeft,
    XFSimpleFlowViewMarginTypeRight,
    
    XFSimpleFlowViewMarginTypeColumn, // cell的列间距
    XFSimpleFlowViewMarginTypeRow, // cell的行间距
} XFSimpleFlowViewMarginType;

@class XFSimpleFlowView;
/**
 *  数据源方法
 */
@protocol XFSimpleFlowViewDataSource <NSObject>

@required
/**
 *  一列上的行数
 *
 */
- (NSUInteger)simpleFlowView:(XFSimpleFlowView *)simpleFlowView numberOfRowsInSection:(NSInteger)section;
/**
 *  返回当前位置上的cell
 *
 */
- (id<XFReusedCellDelegate>)simpleFlowView:(XFSimpleFlowView *)simpleFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
/**
 *  返回组数
 *
 */
- (NSUInteger)numberOfSectionsInSimpleFlowView:(XFSimpleFlowView *)simpleFlowView;
@end

/**
 *  代理方法
 */
@protocol XFSimpleFlowViewDelegate <UIScrollViewDelegate>

@optional
/**
 *  cell内容间距
 */
- (CGFloat)simpleFlowView:(XFReusedScrollView *)simpleFlowView marginForType:(XFSimpleFlowViewMarginType)type;
/**
 *  cell高度
 *
 */
- (CGFloat)simpleFlowView:(XFSimpleFlowView *)simpleFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  cell被点击
 *
 */
- (void)simpleFlowView:(XFSimpleFlowView *)simpleFlowView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface XFSimpleFlowView : XFReusedScrollView

/**
 *  数据源
 */
@property (nonatomic, weak) id<XFSimpleFlowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<XFSimpleFlowViewDelegate> delegate;

/**
 *  布局之前（这是一个勾子方法，用于初始化）
 */
- (void)layoutBefore;
/**
 *  自定义布局当前cell的frame,默认返回CGRectZero（这是一个勾子方法，子类根据需求实现自己的cell布局）
 *
 *  @param row        当前行
 *  @param section    当前组
 *  @param cellHeight 预设cell高
 *
 *  @return cell的frame
 */
- (CGRect)layoutCellAtRow:(NSInteger)row ofSection:(NSInteger)section withCellHeight:(CGFloat)cellHeight;
/**
 *  布局之后（这是一个勾子方法，用于清理数据）
 */
- (void)layoutAfter;

/**
 *  获得内容间距
 */
- (CGFloat)marginTopForContent;
- (CGFloat)marginBottomForContent;
- (CGFloat)marginLeftForContent;
- (CGFloat)marginRightForContent;
/**
 *  获得cell列间距
 *
 */
- (CGFloat)marginColumnForCell;
/**
 *  获得cell行间距
 *
 */
- (CGFloat)marginRowForCell;
/**
 *  通用cell高度（用于高度一致的cell）
 *
 */
- (CGFloat)normalCellHeight;
@end
