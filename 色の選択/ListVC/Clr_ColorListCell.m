//
//  Clr_ColorListCell.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ColorListCell.h"
@interface Clr_ColorListCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *colors;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@end
@implementation Clr_ColorListCell
- (void)model:(ColorListModel *)model {
    self.title.text = model.title;
    if (model.colors.count > 5) {
        self.moreLabel.hidden = NO;
        for (int i = 0; i < 5; i++) {
            ((UIView *)self.colors[i]).backgroundColor = [UIColor colorWithHexString:model.colors[i]];
            
        }
        self.moreLabel.text = [NSString stringWithFormat:@"全部で%lu個", (unsigned long)model.colors.count];
    }else{
        self.moreLabel.hidden = YES;
        for (int i = 0; i < model.colors.count; i++) {
            ((UIView *)self.colors[i]).backgroundColor = [UIColor colorWithHexString:model.colors[i]];
        }
    }
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
