//
//  Clr_ManualVC.m
//  色の選択
//
//  Created by devfalme on 2018/12/11.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ManualVC.h"
#import "UIImageView+Clr_Color.h"
#import "Clr_ColorDotView.h"

static NSUInteger initialCount = 5;


@interface Clr_ManualVC ()
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *delete;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) NSMutableArray <ColorDotView *> *dots;
@end

@implementation Clr_ManualVC

ROUTER_PATH(@"ManualVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手動選択";
    
    self.dots = [NSMutableArray array];
    self.add.backgroundColor = Client->pinkColor();
    self.delete.backgroundColor = Client->pinkColor();
    self.imageView.image = self.image;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self generateDots:initialCount];
    });
    
    [[self.add rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self generateDots:1];
    }];
    
    [[self.delete rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if (self.dots) {
            [self.dots.lastObject removeFromSuperview];
            [self.dots removeLastObject];            
        }
    }];
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    [save setTitle:@"保存する" forState:UIControlStateNormal];
    [save setTitleColor:Client->lightColor() forState:UIControlStateNormal];
    [save sizeToFit];
    [[save rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
        dialogViewController.title = @"タイトルを設定する";
        [dialogViewController addTextFieldWithTitle:@"タイトル" configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
            textField.placeholder = @"20文字を超えない";
            textField.maximumTextLength = 20;
        }];
        [dialogViewController addCancelButtonWithText:@"取り消す" block:nil];
        [dialogViewController addSubmitButtonWithText:@"確定する" block:^(QMUIDialogTextFieldViewController *aDialogViewController) {
            if (aDialogViewController.textFields.firstObject.text.length > 0) {
                ColorListModel *model = [[ColorListModel alloc]init];
                model.title = aDialogViewController.textFields.firstObject.text;
                NSMutableArray *hexs = [NSMutableArray array];
                
                for (ColorDotView *view in self.dots) {
                    [hexs addObject:view.backgroundColor.hexValue];
                }
                model.colors = hexs;
                
                [ColorListModel insertToDB:model];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.showSuccess(@"成功する");
                    [aDialogViewController hide];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [QMUITips showInfo:@"内容を記入してください" inView:self.view hideAfterDelay:1.2];
            }
        }];
        [dialogViewController show];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:save];
}

- (void)generateDots:(NSUInteger)count {

    NSInteger maxWidth = SCREEN_WIDTH - 20 - 45.0;
    NSInteger maxHeight = SCREEN_WIDTH - 20 - 45.0;

    NSMutableArray *centerPoints = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *dots = [NSMutableArray arrayWithCapacity:count];

    for(NSInteger i = 0; i < count; i++){

        CGFloat x = 45 * 0.5 + arc4random() % maxWidth + 1;

        CGFloat y = 45 * 0.5 + arc4random() % maxHeight + 1;

        CGPoint center = CGPointMake(x, y);

        [centerPoints addObject:[NSValue valueWithCGPoint:center]];

        ColorDotView *dotView = [[ColorDotView alloc]init];

        dotView.center = self.imageView.center;

        [self.imageView addSubview:dotView];
        [dots addObject:dotView];
        [self.dots addObject:dotView];
    }

    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        for(NSInteger i = 0; i < count; i++){
            UIView *dotView = dots[i];
            dotView.center = [centerPoints[i]CGPointValue];
            dotView.backgroundColor = [self.imageView colorAtPixel:[centerPoints[i]CGPointValue]];
        }

    } completion:^(BOOL finished) {

    }];

    [self.view layoutIfNeeded];

}

@end
