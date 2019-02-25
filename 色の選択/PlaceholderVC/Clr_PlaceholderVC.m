//
//  Clr_PlaceholderVC.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_PlaceholderVC.h"
#import <ZLPhotoBrowser/ZLPhotoActionSheet.h>

@interface Clr_PlaceholderVC ()
@property (weak, nonatomic) IBOutlet UIButton *manual;
@property (weak, nonatomic) IBOutlet UIButton *automatic;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *select;


@property (nonatomic, retain) UIImage *image;
@end

@implementation Clr_PlaceholderVC

ROUTER_PATH(@"PlaceholderVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"写真を選ぶ";
    
    self.manual.backgroundColor = Client->pinkColor();
    self.automatic.backgroundColor = Client->pinkColor();
    self.select.backgroundColor = Client->pinkColor();
    
    [[self.select rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
        ac.configuration.allowMixSelect = NO;
        ac.configuration.allowSelectVideo = NO;
        ac.configuration.allowSelectGif = NO;
        ac.configuration.allowSelectLivePhoto = NO;
        ac.configuration.languageType = ZLLanguageJapanese;
        
        ac.configuration.navBarColor = Client->pinkColor();
        ac.configuration.bottomBtnsNormalTitleColor = Client->darkColor();
        ac.configuration.maxSelectCount = 1;
        ac.configuration.maxPreviewCount = 0;
        ac.sender = self;
        [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            self.imageView.image = images.firstObject;
            self.image = images.firstObject;
        }];
        
        [ac showPhotoLibrary];
    }];
    
    
    [[self.automatic rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.image) {
            self.showLoading(@"少々お待ちください...");
            NSArray<UIColor *> *colors = ColorsFromImage(self.imageView.image, YES);
            [Router post:ROUTER_API(@"AutomaticVC") parameters:@{@"colors":colors} fail:nil];
        }else{
            self.showError(@"まず画像を選択してください");
        }
    }];
    
    [[self.manual rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.image) {
            self.showLoading(@"少々お待ちください...");
            [Router post:ROUTER_API(@"ManualVC") parameters:@{@"image":self.image} fail:nil];
        }else{
            self.showError(@"まず画像を選択してください");
        }
    }];
    
}



@end
