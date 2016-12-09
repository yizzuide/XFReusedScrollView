//
//  XFHorizontalViewController.m
//  XFReusedScrollViewExample
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFHorizontalViewController.h"
#import "XFSimpleFlowView.h"
#import "XFCell.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface XFHorizontalViewController ()  <XFSimpleFlowViewDataSource,XFSimpleFlowViewDelegate>

@end

@implementation XFHorizontalViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    XFSimpleFlowView * flowView = [[XFSimpleFlowView alloc] init];
    flowView.frame = CGRectMake(0, 0, 320, 400);
    flowView.dataSource = self;
    flowView.delegate = self;
    [self.view addSubview:flowView];
}

- (NSUInteger)numberOfSectionsInSimpleFlowView:(XFSimpleFlowView *)simpleFlowView
{
    return 10;
}

- (NSUInteger)simpleFlowView:(XFSimpleFlowView *)simpleFlowView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (id<XFReusedCellDelegate>)simpleFlowView:(XFSimpleFlowView *)simpleFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    
    XFCell *cell = [simpleFlowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [XFCell new];
        cell.identifier = ID;
        cell.backgroundColor = randomColor;
        NSLog(@"正在创建新对象。。");
    }
    [cell setText:[NSString stringWithFormat:@"%zd,%zd",indexPath.section,indexPath.row]];
    return cell;
}

- (void)simpleFlowView:(XFSimpleFlowView *)simpleFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}
@end
