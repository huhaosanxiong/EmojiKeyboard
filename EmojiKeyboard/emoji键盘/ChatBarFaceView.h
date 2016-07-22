//
//  ChatBarFaceView.h
//  ChatDemo
//
//  Created by mac_111 on 16/2/29.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatbarFaceDelegate <NSObject>

- (void)faceClick:(NSString*)faceName andFaceNumber:(NSInteger)number;


@end
@interface ChatBarFaceView : UIView

@property (nonatomic, strong) NSArray *titleImages;

@property (nonatomic, strong) UIButton *sendBtn;
@property  (nonatomic,strong) UIButton  *starButton;
@property (nonatomic, weak)id<ChatbarFaceDelegate>delegate;




- (id)initWithFrame:(CGRect)frame with:(BOOL)isGif;


@end
