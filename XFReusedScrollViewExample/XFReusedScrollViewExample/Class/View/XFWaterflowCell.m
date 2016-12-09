//
//  XFWaterflowCell.m
//  XFReusedScrollViewExample
//
//  Created by 付星 on 16/9/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWaterflowCell.h"

@interface XFWaterflowCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation XFWaterflowCell

- (void)setText:(NSString *)text {
    self.titleLabel.text = text;
}
@end
