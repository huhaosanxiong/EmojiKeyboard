//
//  HNEmojiContact.h
//  BeautyLiveShow
//
//  Created by mac-333 on 16/7/8.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNEmojiContact : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;

+ (instancetype)emotionWithDict:(NSDictionary *)dict;

+ (instancetype)emotionWithChs:(NSString *)chs png:(NSString *)png;
@end
