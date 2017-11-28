//
//  XFMenuCell.h
//  XFReusedScrollViewExample
//
//  Created by Yizzuide on 2017/11/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFReusedCellDelegate.h"

@interface XFMenuCell : UIButton <XFReusedCellDelegate>

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) BOOL selected;

- (void)setText:(NSString *)text;
@end
