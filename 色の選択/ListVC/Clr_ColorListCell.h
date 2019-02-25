//
//  Clr_ColorListCell.h
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "QMUITableViewCell.h"
#import "Clr_ColorListModel.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef ColorListCell
#define ColorListCell Clr_ColorListCell
#endif

@interface Clr_ColorListCell : QMUITableViewCell

- (void)model:(ColorListModel *)model;


@end

NS_ASSUME_NONNULL_END
