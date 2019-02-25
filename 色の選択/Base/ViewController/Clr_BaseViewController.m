//
//  Clr_BaseViewController.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_BaseViewController.h"

@implementation Clr_BaseViewController

- (void)viewWillDisappear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    self.hideHud();
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    self.view.backgroundColor = Client->lightColor();
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
