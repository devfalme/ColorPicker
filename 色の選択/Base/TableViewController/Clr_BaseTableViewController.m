//
//  Clr_BaseTableViewController.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_BaseTableViewController.h"

@interface Clr_BaseTableViewController ()

@end

@implementation Clr_BaseTableViewController
- (void)viewWillDisappear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    self.hideHud();
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = Client->lightColor();
    self.tableView.backgroundColor = Client->lightColor();
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    
}


- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (nullable UIColor *)titleViewTintColor {
    return Client->lightColor();
}

- (nullable UIColor *)navigationBarBarTintColor {
    return Client->pinkColor();
}

- (nullable UIColor *)navigationBarTintColor {
    return Client->lightColor();
}
@end
