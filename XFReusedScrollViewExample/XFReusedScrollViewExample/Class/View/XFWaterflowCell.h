//
//  XFWaterflowCell.h
//  XFReusedScrollViewExample
//
//  Created by 付星 on 16/9/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFReusedCellDelegate.h"

@interface XFWaterflowCell : UIView <XFReusedCellDelegate>

@property (nonatomic, copy) NSString *identifier;

- (void)setText:(NSString *)text;
@end
