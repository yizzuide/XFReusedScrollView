//
//  XFReusedScrollView.h
//  XFReusedScrollView
//
//  Created by 付星 on 16/9/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFReusedCellDelegate.h"

@interface XFReusedScrollView : UIScrollView
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
 *  注册缓存cell的类型，用于内容自动创建
 *
 *  @param cellClass  cell的类型
 *  @param identifier 缓存cell标识
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
/**
 *  注册xib的cell类型
 *
 */
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;

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

@end
