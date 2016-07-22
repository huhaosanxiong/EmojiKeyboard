//
//  ChatBarVC.h
//  ChatDemo
//
//  Created by mac_111 on 16/2/29.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FunctionViewHeight 200.0f

typedef void  (^textViewregist) (BOOL*isRegist);
typedef void  (^textViewFrameChange) (float lineHeight);

typedef void  (^selfViewFrameChange) (CGRect  frame);
typedef void   (^sendMessage) (NSString *text);

/**
 *  functionView 类型
 */
typedef NS_ENUM(NSUInteger, ChatFunctionViewShowType){
    ChatFunctionViewSendMessage, //!< 发送消息
    ChatFunctionViewShowFace     /**< 显示表情View */,
    ChatFunctionViewShowKeyboard /**< 显示键盘 */,
    ChatFunctionViewShowNothing  /**< 不显示functionView */,
};



@interface ChatBarVC : UIView<UITextViewDelegate>

@property (nonatomic,strong)UITextView  *textview;
@property (nonatomic,assign)float    hightText;
@property (nonatomic,assign)float   textLineHeight;
@property (nonatomic,assign)float   primeTextheight;

@property (assign, nonatomic, readonly) CGFloat bottomHeight; 

@property (nonatomic,strong)UIButton      *voiceBut;   // 语音按钮
@property (nonatomic,strong)UIButton      *emojiBut;   //  表情按钮
@property (nonatomic,strong)UIButton      *moreBut;    // 更多按钮

@property  (nonatomic,copy)NSString        *sendTextStr;

@property (nonatomic,copy)textViewregist  registBlock;

@property (nonatomic,copy)textViewFrameChange   changBlock;  //输入框 textView根据字符变高的回调

@property (nonatomic,copy)selfViewFrameChange   selfViewBlock;  // 本view frame 变化时的回调。

@property (nonatomic,copy)sendMessage           sendBlock;   // 发送消息的回调；


- (void)scrollViewForChatBarView;

@end
