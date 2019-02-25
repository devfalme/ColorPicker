//
//  Clr_ColorDotView.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_ColorDotView.h"
#import "UIImageView+Clr_Color.h"

static CGFloat dotSize = 45.f;


@implementation Clr_ColorDotView
- (instancetype)init {
    if(self = [super init]){
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:CGRectMake(0, 0, dotSize, dotSize)]){
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.frame = CGRectMake(0, 0, dotSize, dotSize);
    self.layer.cornerRadius = dotSize * 0.5f;
    self.layer.borderWidth = 2.f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = UIColor.whiteColor;
    self.layer.borderColor = UIColor.flatWhiteColorDark.CGColor;
}

- (void)zoom:(BOOL)zoom {
    [UIView animateWithDuration:0.25 delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (zoom) {
            self.transform = CGAffineTransformMakeScale(2.f, 2.f);
        }else{
            self.transform = CGAffineTransformMakeScale(1.f, 1.f);
        }
    } completion:nil];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.layer.borderColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:backgroundColor isFlat:YES].CGColor;
}

#pragma mark---touch action move dots

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self zoom:YES];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint newcenter = [[touches anyObject] locationInView:self.superview];
    
    float halfx = CGRectGetMidX(self.bounds)/2.0;
    newcenter.x = MAX(halfx, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    float halfy = CGRectGetMidY(self.bounds)/2.0;
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    self.backgroundColor = [((UIImageView *)self.superview) colorAtPixel:newcenter];
    
    self.center = newcenter;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self zoom:NO];
}
@end
