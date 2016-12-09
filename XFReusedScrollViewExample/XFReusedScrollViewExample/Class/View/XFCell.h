//
//  XFStudentSeatCell.h
//  AdjustStudentSeat
//
//  Created by 付星 on 16/9/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFReusedCellDelegate.h"

@interface XFCell : UIView <XFReusedCellDelegate>

@property (nonatomic, copy) NSString *identifier;

- (void)setText:(NSString *)text;
@end
