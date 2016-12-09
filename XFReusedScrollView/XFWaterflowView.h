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
 *  瀑布流列数
 */
- (NSInteger)numberOfColumnsInWaterflowView:(XFWaterflowView *)waterflowView;
@end

@interface XFWaterflowView : XFSimpleFlowView
/**
 *  数据源
 */
@property (nonatomic, weak) id<XFWaterflowViewDataSource> dataSource;

/**
 *  cell的宽度（外部可根据这个宽度来计算等比例图片的高度）
 */
- (CGFloat)cellWidth;
@end
