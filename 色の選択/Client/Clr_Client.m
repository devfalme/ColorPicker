//
//  Clr_Client.m
//  色の選択
//
//  Created by devfalme on 2018/12/10.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "Clr_Client.h"
#import "Clr_BaseNavigationController.h"

static Client_t *client = NULL;
static NSString const *factor = @"3b453f04a6d54485a9672f7deafaeaf9";

static NSString *_encode(NSString *string) {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger length = factor.length;
    const char *keys = [factor cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cKey[length];
    memcpy(cKey, keys, length);
    NSMutableData *encryptData = [[NSMutableData alloc] initWithCapacity:length];
    const Byte *point = data.bytes;
    for (int i = 0; i < data.length; i++) {
        int l = i % length;
        char c = cKey[l];
        Byte b = (Byte) ((point[i]) ^ c);
        [encryptData appendBytes:&b length:1];
    }
    return [[NSString alloc] initWithData:encryptData.copy encoding:NSUTF8StringEncoding];
}

static NSString *_decode(NSString *string) {
    return _encode(string);
}

static UIViewController *_rootViewController(void) {
    UIViewController *vc = [Router search:ROUTER_API(@"RootViewController")];
    UIViewController *rootVC = [[Clr_BaseNavigationController alloc]initWithRootViewController:vc];
    return rootVC;
}

static UIColor *_lightColor(void) {
    return [UIColor colorWithHexString:@"F2F3F4"].flatten;
}
static UIColor *_darkColor(void) {
    return [UIColor colorWithHexString:@"4166D4"].flatten;
}
static UIColor *_pinkColor(void) {
    return [UIColor colorWithHexString:@"FF707A"].flatten;
}

static NSMutableArray <ColorListModel *> *_colorModels(void) {
    BOOL isFrist = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFrist"] isEqualToString:@"YES"];
    if (isFrist) {
        NSMutableArray *colors = [NSMutableArray array];
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultColors" ofType:@"plist"]];
        for (NSDictionary *obj in arr) {
            ColorListModel *model = [[ColorListModel alloc]init];
            [model setValuesForKeysWithDictionary:obj];
            [colors addObject:model];
        }
        [ColorListModel insertArrayByAsyncToDB:colors];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFrist"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return [ColorListModel searchWithWhere:nil];
}

void needIntroduce(void) {
    [[NSUserDefaults standardUserDefaults] setObject:@([[NSDate date] timeIntervalSince1970]).stringValue forKey:@"needIntroduce"];
}

static void _setup(void) {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFrist"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFrist"];
    }
    needIntroduce();
    [[NSUserDefaults standardUserDefaults] synchronize];
}



Client_t *defaultClient(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = malloc(sizeof(Client_t));
        client->lightColor = _lightColor;
        client->darkColor = _darkColor;
        client->pinkColor = _pinkColor;
        client->rootViewController = _rootViewController;
        client->colorModels = _colorModels;
        client->setup = _setup;
        client->encode = _encode;
        client->decode = _decode;
    });
    return client;
}
