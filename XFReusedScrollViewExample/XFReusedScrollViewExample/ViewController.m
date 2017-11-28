//
//  ViewController.m
//  XFReusedScrollViewExample
//
//  Created by 付星 on 16/9/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "ViewController.h"
#import "XFSettings.h"
#import "UIViewController+XFSettings.h"
#import "XFHorizontalViewController.h"
#import "XFWaterflowViewController.h"
#import "XFVerticalViewController.h"
#import "XFMenuViewController.h"

@interface ViewController () <XFSettingTableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"XFReusedScrollView";
    // set cell attrs
    XFCellAttrsData *cellAttrsData = [[XFCellAttrsData alloc] init];
    // 设置图标大小
    cellAttrsData.contentIconSize = 20;
    // 设置内容间距
    cellAttrsData.contentEachOtherPadding = 15;
    // 标题文字大小（其它文字会按个大小自动调整）
    cellAttrsData.contentTextMaxSize = 13;
    // 表格风格
    cellAttrsData.tableViewStyle = UITableViewStyleGrouped;
    
    self.xf_cellAttrsData = cellAttrsData;
    // 设置数据源
    self.xf_dataSource = self;
    // 调用配置设置
    [self xf_setup];
}

- (NSArray *)settingItems
{
    return @[ // 对应UITableView的Section数组
             @{ // 每一个Section
                
                 XFSettingGroupItems : @[ // 对应UITableView的cell数组
                         @{
                             XFSettingItemTitle: @"横向分组布局",
                             XFSettingItemClass: [XFSettingArrowItem class],
                             XFSettingItemDestViewControllerClass:[XFHorizontalViewController class],
                             },
                         @{
                             XFSettingItemTitle: @"纵向分组布局",
                             XFSettingItemClass: [XFSettingArrowItem class],
                             XFSettingItemDestViewControllerClass:[XFVerticalViewController class],
                             },
                         @{
                             XFSettingItemTitle: @"滚动菜单",
                             XFSettingItemClass: [XFSettingArrowItem class],
                             XFSettingItemDestViewControllerClass:[XFMenuViewController class],
                             },
                         @{
                             XFSettingItemTitle: @"瀑布流布局",
                             XFSettingItemClass: [XFSettingArrowItem class],
                             XFSettingItemDestViewControllerClass:[XFWaterflowViewController class],
                             }
                         ],
                 
                 }
             ];
}

@end
