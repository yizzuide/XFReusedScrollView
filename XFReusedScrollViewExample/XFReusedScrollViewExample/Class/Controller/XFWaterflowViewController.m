//
//  XFWaterflowViewController.m
//  XFReusedScrollViewExample
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFWaterflowViewController.h"
#import "XFWaterflowView.h"
#import "XFWaterflowCell.h"


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface XFWaterflowViewController () <XFWaterflowViewDataSource,XFWaterflowViewDelegate>

@end

@implementation XFWaterflowViewController

static NSString *ID = @"cell";
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    XFWaterflowView * flowView = [[XFWaterflowView alloc] init];
    flowView.frame = CGRectMake(0, 0, 320, 400);
    flowView.dataSource = self;
    flowView.delegate = self;
    [self.view addSubview:flowView];
    
    // 注册cell
    //[flowView registerClass:[XFCell class] forCellReuseIdentifier:ID];
    [flowView registerNib:[UINib nibWithNibName:@"XFWaterflowCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (NSUInteger)simpleFlowView:(XFSimpleFlowView *)simpleFlowView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (id<XFReusedCellDelegate>)simpleFlowView:(XFSimpleFlowView *)simpleFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XFWaterflowCell *cell = [simpleFlowView dequeueReusableCellWithIdentifier:ID];
    cell.backgroundColor = randomColor;
    [cell setText:[NSString stringWithFormat:@"%zd,%zd",indexPath.section,indexPath.row]];
    return cell;
}

- (void)simpleFlowView:(XFSimpleFlowView *)simpleFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}

- (CGFloat)simpleFlowView:(XFSimpleFlowView *)simpleFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return arc4random() % 100 + 100.f;
}

- (CGFloat)simpleFlowView:(XFReusedScrollView *)simpleFlowView marginForType:(XFSimpleFlowViewMarginType)type
{
    switch (type) {
        case XFSimpleFlowViewMarginTypeRow:
            return 20.f;
        default:
            return 8.f;
            
    }
}
@end
