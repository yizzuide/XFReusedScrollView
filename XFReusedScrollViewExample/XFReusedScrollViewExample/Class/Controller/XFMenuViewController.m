//
//  XFMenuViewController.m
//  XFReusedScrollViewExample
//
//  Created by Yizzuide on 2017/11/28.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFMenuViewController.h"
#import "XFTextFlowView.h"
#import "XFMenuCell.h"

@interface XFMenuViewController () <XFSimpleFlowViewDataSource, XFTextFlowViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *tags;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *selectFlags;
@property (nonatomic, assign) NSInteger lastSelectIndex;
@end

@implementation XFMenuViewController

static NSString *kMenuCellID = @"kXFMenuCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tags = @[@"iT互联网",@"创意设计",@"语言留学",@"生产种植",@"培训考试",@"编程",@"iT互联网",@"创意设计",@"语言留学",@"生产种植",@"培训考试",@"编程"];
    _selectFlags = @[].mutableCopy;
    for (int i = 0; i< _tags.count; i++) {
        if (i == 0) {
            [_selectFlags addObject:@(YES)];
            continue;
        }
        [_selectFlags addObject:@(NO)];
    }
    
    XFTextFlowView *flowView = [[XFTextFlowView alloc] init];
//    flowView.backgroundColor = [UIColor grayColor];
    flowView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 44);
    flowView.dataSource = self;
    flowView.delegate = self;
    flowView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:flowView];
    
    [flowView registerClass:[XFMenuCell class] forCellReuseIdentifier:kMenuCellID];

    
}

- (NSUInteger)simpleFlowView:(XFSimpleFlowView *)simpleFlowView numberOfRowsInSection:(NSInteger)section
{
    return _tags.count;
}

- (CGFloat)textFlowView:(XFTextFlowView *)textFlowView widthForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL selected = [self.selectFlags[indexPath.row] boolValue];
    if (selected) {
        return [_tags[indexPath.row] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.f]}].width + 13.5f;
    }
    return [_tags[indexPath.row] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.f]}].width + 13.5f;
}

- (id<XFReusedCellDelegate>)simpleFlowView:(XFSimpleFlowView *)simpleFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFMenuCell *cell = [simpleFlowView dequeueReusableCellWithIdentifier:kMenuCellID];
    BOOL selected = [self.selectFlags[indexPath.row] boolValue];
    cell.selected = selected;
    [cell setText:_tags[indexPath.row]];
    return cell;
}

- (CGFloat)simpleFlowView:(XFReusedScrollView *)simpleFlowView marginForType:(XFSimpleFlowViewMarginType)type
{
    switch (type) {
        case XFSimpleFlowViewMarginTypeLeft:
        case XFSimpleFlowViewMarginTypeRight:
            return 80;
        default:
            return 0;
    }
    return 0;
}

- (void)simpleFlowView:(XFSimpleFlowView *)simpleFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL selected = [self.selectFlags[indexPath.row] boolValue];
    if (!selected) {
        self.selectFlags[self.lastSelectIndex] = @(NO);
        self.selectFlags[indexPath.row] = @(!selected);
        self.lastSelectIndex = indexPath.row;
    }
    [simpleFlowView reloadData];
    
}


@end
