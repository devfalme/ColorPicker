//
//  Clr_ColorListVC.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ColorListVC.h"
#import "Clr_ColorListCell.h"
#import "Clr_ColorListFooter.h"

@interface Clr_ColorListVC ()

@property (nonatomic, retain) NSMutableArray<ColorListModel *> *colors;

@end

@implementation Clr_ColorListVC

ROUTER_PATH(@"RootViewController");

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_colors) {
        self.colors = Client->colorModels();
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"色の板";

    [self.tableView registerNib:[UINib nibWithNibName:@"Clr_ColorListCell" bundle:nil] forCellReuseIdentifier:@"Clr_ColorListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    addButton.backgroundColor = Client->lightColor();
    addButton.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    addButton.layer.shadowOpacity = .3;
    addButton.layer.shadowOffset = CGSizeMake(0, 2);
    addButton.layer.cornerRadius = 40.0;
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-34);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.right.equalTo(self.view).offset(-25);
    }];
    [[addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Router get:ROUTER_API(@"PlaceholderVC") fail:nil];
    }];
    
    [self.tableView registerClass:[Clr_ColorListFooter class] forHeaderFooterViewReuseIdentifier:@"Clr_ColorListFooter"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Clr_ColorListFooter"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.colors.count) {
        return 60.0;
    }else{
        return 0.1;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"削る";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ColorListModel *model = self.colors[indexPath.row];
        [model deleteToDB];
        [self.colors removeObject:model];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Clr_ColorListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(ColorListCell *)cell model:self.colors[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Router post:ROUTER_API(@"ColorBoardVC") parameters:@{@"model":self.colors[indexPath.row]} fail:nil];
}

- (NSMutableArray<Clr_ColorListModel *> *)colors {
    if (!_colors) {
        self.colors = Client->colorModels();
    }return _colors;
}


@end
