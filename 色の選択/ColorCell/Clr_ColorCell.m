//
//  Clr_ColorCell.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ColorCell.h"
@interface Clr_ColorCell ()
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end
@implementation Clr_ColorCell
- (void)color:(UIColor *)color {
    self.hexLabel.text = color.hexValue;
    self.hexLabel.textColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:color isFlat:YES];
    self.colorView.backgroundColor = color;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = Client->lightColor();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
