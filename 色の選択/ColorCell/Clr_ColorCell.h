//
//  Clr_ColorCell.h
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef ColorCell
#define ColorCell Clr_ColorCell
#endif
@interface Clr_ColorCell : QMUITableViewCell

- (void)color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
