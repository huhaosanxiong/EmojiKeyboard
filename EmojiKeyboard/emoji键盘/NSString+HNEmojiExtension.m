//
//  NSString+HNEmojiExtension.m
//  BeautyLiveShow
//
//  Created by mac-333 on 16/7/8.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import "NSString+HNEmojiExtension.h"
#import "NaturalData.h"
#import <CoreText/CoreText.h>
#import "Header.h"


@implementation NSString (HNEmojiExtension)


- (NSAttributedString *)emotionStringWithEmojiHeight:(CGFloat)WH
{
    NSMutableArray *emotions = [NSMutableArray array];
    
    //从plist中获取图片
    
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *path = [bundle pathForResource:@"emotions" ofType:@"plist"];
//    for (NSArray *arr in [[NSArray alloc] initWithContentsOfFile:path]) {
//        for (NSDictionary *dict in arr) {
//            HNEmojiContact *emotion = [HNEmojiContact emotionWithDict:dict];
//            [emotions addObject:emotion];
//        }
//    }
    
    
    NSArray *imageNameArray = [NaturalData shareInStance].imageFaceArray;
    NSArray *faceNameArray = [NaturalData shareInStance].faceArray;
    for (int i = 0; i<imageNameArray.count; i++) {
        HNEmojiContact *emotion = [HNEmojiContact emotionWithChs:faceNameArray[i] png:imageNameArray[i]];
        [emotions addObject:emotion];
    }
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    for(NSTextCheckingResult *match in resultArray) {
        NSRange range = [match range];
        NSString *subStr = [self substringWithRange:range];
        
        for (int i = 0; i < emotions.count; i ++)
        {
            HNEmojiContact *emotion = emotions[i];
            if ([emotion.chs isEqualToString:subStr])
            {
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                
                //这个-3 需要自己调整。。
                textAttachment.bounds = CGRectMake(0, -3, WH, WH);
                NSString *emojiString = [NSString stringWithFormat:@"%@",emotion.png];
                textAttachment.image = [UIImage imageNamed:emojiString];
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                
                [imageArray addObject:imageDic];
                
            }
        }
    }
    
    for (NSInteger i = imageArray.count -1; i >= 0; i--)
    {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
        
    }
    
    return attributeString;
    
}


- (CGFloat)coreTextGetHeight{
    CGFloat height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString ( (CFAttributedStringRef)[self emotionStringWithEmojiHeight:13]);
    CGRect box = CGRectMake(0,0, 2*MAXWIDTH/3.0-16, CGFLOAT_MAX);
    
    CFIndex startIndex = 0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, box);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(startIndex, 0), path, NULL);
    
    CFArrayRef lineArray = CTFrameGetLines(frame);
    CFIndex j = 0, lineCount = CFArrayGetCount(lineArray);
    CGFloat lineHeight, ascent, descent, leading;
    
    for (j=0; j < lineCount; j++) {
        CTLineRef currentLine = (CTLineRef)CFArrayGetValueAtIndex(lineArray, j);
        CTLineGetTypographicBounds(currentLine, &ascent, &descent, &leading);
        lineHeight = ascent + descent + leading;
        height += lineHeight;
    }
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
    return height;
}
@end
