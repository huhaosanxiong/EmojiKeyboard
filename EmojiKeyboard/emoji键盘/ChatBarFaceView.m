//
//  ChatBarFaceView.m
//  ChatDemo
//
//  Created by mac_111 on 16/2/29.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import "ChatBarFaceView.h"
#import "NaturalData.h"
#import "EmojiScrollView.h"
#import "Header.h"




@interface ChatBarFaceView()<emojiScrollViewDelegate>
{
    
}
@property (nonatomic, assign)NSInteger     totle;
@property (nonatomic,assign)NSInteger        index;

@property (nonatomic,strong)EmojiScrollView  *emojVC;
@property (nonatomic,strong)UIPageControl     *emojipage;
@property  (nonatomic,strong)UIPageControl    *gifpage;



@end
@implementation ChatBarFaceView
- (id)initWithFrame:(CGRect)frame with:(BOOL)isGif
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.emojVC];

    }
    
    return self;
    
}

- (UIPageControl*)emojipage
{
    if (!_emojipage) {
        _emojipage = [[UIPageControl alloc]initWithFrame:CGRectMake((MAXWIDTH -150)/2, self.frame.size.height -30, 150, 20)];
        _emojipage.pageIndicatorTintColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
        _emojipage.currentPageIndicatorTintColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
        _emojipage.userInteractionEnabled = NO;
    }
    return _emojipage;
}




- (EmojiScrollView*)emojVC
{
    if (!_emojVC) {
        _emojVC = [[EmojiScrollView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH,self.frame.size.height-20) AndImageArray:[NaturalData shareInStance].imageFaceArray];
        _emojVC.emojiDelegate = self;
        [_emojVC emjiScrollBack];
        

    }
    return _emojVC;
}


- (void)emojiBackPageNumber:(NSInteger)number andIndex:(NSInteger)index
{
    [self addSubview:self.emojipage];
    self.emojipage.numberOfPages = number;
    self.emojipage.currentPage = index;
}

- (void)gifEmojiBackPageNumber:(NSInteger)number andIndex:(NSInteger)index
{
    
     [self addSubview:self.gifpage];
     self.gifpage.numberOfPages = number;
     self.gifpage.currentPage = index;

    
}




// emojiDelegate

- (void)deleteString
{
    NSString   *nameStr = @"[删除]";
    if (self.delegate &&[self.delegate respondsToSelector:@selector(faceClick:andFaceNumber:)]) {
        [self.delegate faceClick:nameStr andFaceNumber:0];
    }
}

- (void)emojiSelcet:(NSInteger)numface
{
    
    NSString   *faceName =[[NaturalData shareInStance].faceArray objectAtIndex:numface];

    if (self.delegate &&[self.delegate respondsToSelector:@selector(faceClick:andFaceNumber:)]) {
        [self.delegate faceClick:faceName andFaceNumber:numface];
        
    }
}


- (void)gifEmojiSelcet:(NSInteger)numface
{
  NSLog(@"输入额是什么：%@",[[NaturalData shareInStance].gifImageArray objectAtIndex:numface]);
  
    
    
}

- (void)changFaceKind:(UIButton*)button
{
    if (button != self.starButton) {
        [self.starButton setBackgroundColor:[UIColor whiteColor]];
        self.starButton.selected = NO;
        self.starButton = button;
        [self.starButton setBackgroundColor:self.backgroundColor];
    }
    self.starButton.selected = YES;
    
    NSInteger  butTag =button.tag-10000;
    if (butTag ==0) {
        _emojVC.hidden = NO;
        _emojipage.hidden=NO;
        
    }else if (butTag ==1){
        _emojVC.hidden = YES;
        _emojipage.hidden = YES;

    }
}
@end
