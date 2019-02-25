//
//  Clr_ColorListModel.h
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef ColorListModel
#define ColorListModel Clr_ColorListModel
#endif

@interface Clr_ColorListModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray<NSString *> *colors;

@end

NS_ASSUME_NONNULL_END
