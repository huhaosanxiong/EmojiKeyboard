//
//  NSString+HNEmojiExtension.h
//  BeautyLiveShow
//
//  Created by mac-333 on 16/7/8.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HNEmojiContact.h"
@interface NSString (HNEmojiExtension)

/**
 *  生成表情 字符串
 *  WH  表情高度
 */
- (NSAttributedString *)emotionStringWithEmojiHeight:(CGFloat)WH;


- (CGFloat)coreTextGetHeight;
@end
