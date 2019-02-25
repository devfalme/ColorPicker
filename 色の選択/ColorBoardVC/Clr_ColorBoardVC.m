//
//  Clr_ColorBoardVC.m
//  色の選択
//
//  Created by devfalme on 2018/12/11.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ColorBoardVC.h"
#import "Clr_ColorCell.h"
#import "Clr_ColorListModel.h"

@interface Clr_ColorBoardVC ()

@property (nonatomic, retain) ColorListModel *model;

@end

@implementation Clr_ColorBoardVC

ROUTER_PATH(@"ColorBoardVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.title;
    [self.tableView registerNib:[UINib nibWithNibName:@"Clr_ColorCell" bundle:nil] forCellReuseIdentifier:@"Clr_ColorCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.colors.count;
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
    [(ColorCell *)cell color:[UIColor colorWithHexString:self.model.colors[indexPath.row]]];
}

@end
