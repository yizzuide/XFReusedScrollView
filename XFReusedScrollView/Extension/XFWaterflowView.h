//
//  XFWaterflowView.h
//  XFReusedScrollView
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFSimpleFlowView.h"

@class XFWaterflowView;
@protocol XFWaterflowViewDataSource <XFSimpleFlowViewDataSource>

@optional
/**
 *  流的列数
 */
- (NSInteger)numberOfColumnsInWaterflowView:(XFWaterflowView *)waterflowView;
@end

@protocol XFWaterflowViewDelegate <XFSimpleFlowViewDelegate>

@optional
/**
 *  水流布局cell的宽度是否等于高度
 */
- (BOOL)waterflowViewCanWidthEqualsHeight:(XFReusedScrollView *)waterflowView;

@end

@interface XFWaterflowView : XFSimpleFlowView
/**
 *  数据源
 */
@property (nonatomic, weak) id<XFWaterflowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<XFWaterflowViewDelegate> delegate;

/**
 *  cell的宽度（外部可根据这个宽度来计算等比例图片的高度）
 */
- (CGFloat)cellWidth;
@end
