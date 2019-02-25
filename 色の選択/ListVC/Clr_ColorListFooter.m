//
//  Clr_ColorListFooter.m
//  色の選択
//
//  Created by devfalme on 2018/12/11.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ColorListFooter.h"
@interface Clr_ColorListFooter ()
@property (nonatomic, retain) UILabel *title;
@end
@implementation Clr_ColorListFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = Client->lightColor();
        self.contentView.backgroundColor = Client->lightColor();
        self.title = [[UILabel alloc]init];
        self.title.text = @"左滑りで削除";
        self.title.font = [UIFont systemFontOfSize:20];
        self.title.textColor = [UIColor colorWithHexString:@"#4166D4"];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }return self;
}

@end
