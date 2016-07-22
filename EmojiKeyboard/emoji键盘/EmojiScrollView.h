//
//  EmojiScrollView.h
//  ChatDemo
//
//  Created by mac_111 on 16/3/2.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void  (^scrollViewSlide) (NSInteger totle ,NSInteger  index);

@protocol emojiScrollViewDelegate <NSObject>


- (void)emojiSelcet:(NSInteger)numface;

- (void)deleteString ;


- (void)emojiBackPageNumber:(NSInteger)number andIndex:(NSInteger)index;


@end

@interface EmojiScrollView : UIScrollView

- (void)addPageControl;

-(id)initWithFrame:(CGRect)frame AndImageArray:(NSArray*)souceArray;

@property(nonatomic,weak)id<emojiScrollViewDelegate> emojiDelegate;

@property (nonatomic,copy)scrollViewSlide       slideBlock;

-  (void)emjiScrollBack;



@end
