//
//  XFTextFlowView.h
//  XFReusedScrollViewExample
//
//  Created by Yizzuide on 2017/11/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFSimpleFlowView.h"

@class XFTextFlowView;
@protocol XFTextFlowViewDelegate <XFSimpleFlowViewDelegate>
/*
 * 自定义文本宽度
 */
- (CGFloat)textFlowView:(XFTextFlowView *)textFlowView widthForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface XFTextFlowView : XFSimpleFlowView
/*
 * 是否禁用迷雾遮罩
 */
@property (nonatomic, assign) BOOL maskDisabled;
@property (nonatomic, weak) id<XFTextFlowViewDelegate> delegate;
@end
