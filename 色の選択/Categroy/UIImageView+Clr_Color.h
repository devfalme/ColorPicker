//
//  UIImageView+Clr_Color.h
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Clr_Color)
- (UIColor *)colorAtPixel:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
