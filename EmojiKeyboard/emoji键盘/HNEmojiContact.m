//
//  HNEmojiContact.m
//  BeautyLiveShow
//
//  Created by mac-333 on 16/7/8.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import "HNEmojiContact.h"

@implementation HNEmojiContact


+ (instancetype)emotionWithDict:(NSDictionary *)dict
{
    HNEmojiContact *emotion = [[HNEmojiContact alloc] init];
    emotion.chs = dict[@"chs"];
    emotion.png = dict[@"png"];
    
    return emotion;
}

+ (instancetype)emotionWithChs:(NSString *)chs png:(NSString *)png
{
    HNEmojiContact *emotion = [[HNEmojiContact alloc] init];
    emotion.chs = chs;
    emotion.png = png;
    
    return emotion;
}
@end
