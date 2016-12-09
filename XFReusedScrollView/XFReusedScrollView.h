//
//  XFReusedScrollView.h
//  XFReusedScrollView
//
//  Created by 付星 on 16/9/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFReusedCellDelegate.h"


typedef enum {
    // ScrollView上下左右间距
    XFReusedScrollViewMarginTypeTop,
    XFReusedScrollViewMarginTypeBottom,
    XFReusedScrollViewMarginTypeLeft,
    XFReusedScrollViewMarginTypeRight,
    
    XFReusedScrollViewMarginTypeColumn, // cell的列间距
    XFReusedScrollViewMarginTypeRow, // cell的行间距
} XFReusedScrollViewMarginType;


@class XFReusedScrollView;
@protocol XFReusedScrollViewDelegate <UIScrollViewDelegate>

@optional
/**
 *  cell内容间距
 */
- (CGFloat)reusedScrollView:(XFReusedScrollView *)reusedScrollView marginForType:(XFReusedScrollViewMarginType)type;
@end

@interface XFReusedScrollView : UIScrollView

@property (nonatomic, weak) id<XFReusedScrollViewDelegate> delegate;
/**
 *  所有cell的frame数据
 */
@property (nonatomic, strong) NSMutableArray *cellFrames;
/**
 *  正在展示的cell
 */
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
/**
 *  缓存池（用Set，存放离开屏幕的cell）
 */
@property (nonatomic, strong) NSMutableSet *reusableCells;
/**
 *  禁止Touch事件的向下派发
 */
@property (nonatomic, assign) BOOL disableDispathTouchEvent;

/**
 *  刷新数据（子类必需调用父类实现）
 */
- (void)reloadData;

/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 *  返回一个正要显示的cell对象（勾子方法，子类必需实现）
 *
 *  @return cell对象（必需实现XFReusedCellDelegate协议）
 */
- (id<XFReusedCellDelegate>)cellAtIndex:(NSInteger)index;


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
@end
