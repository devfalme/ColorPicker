//
//  Clr_AutomaticVC.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_AutomaticVC.h"
#import "Clr_ColorCell.h"
#import "Clr_ColorListModel.h"

@interface Clr_AutomaticVC ()
@property (nonatomic, retain) NSArray<UIColor *> *colors;
@end

@implementation Clr_AutomaticVC

ROUTER_PATH(@"AutomaticVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自動識別";
    [self.tableView registerNib:[UINib nibWithNibName:@"Clr_ColorCell" bundle:nil] forCellReuseIdentifier:@"Clr_ColorCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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
                for (UIColor *color in self.colors) {
                    [hexs addObject:color.hexValue];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Clr_ColorCell"];
    [cell updateCellAppearanceWithIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(ColorCell *)cell color:self.colors[indexPath.row]];
}
@end
