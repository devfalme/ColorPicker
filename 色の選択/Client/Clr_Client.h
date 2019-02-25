//
//  Clr_Client.h
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Clr_ColorListModel.h"
#ifndef Client
#define Client defaultClient()
#endif

typedef struct Clr_Client {
    NSString *(*decode)(NSString *string);
    NSString *(*encode)(NSString *string);
    UIColor *(*lightColor)(void);
    UIColor *(*darkColor)(void);
    UIColor *(*pinkColor)(void);
    NSMutableArray <ColorListModel *> *(*colorModels)(void);
    UIViewController *(*rootViewController)(void);
    void (*setup)(void);
} Client_t;


extern Client_t *defaultClient(void);
