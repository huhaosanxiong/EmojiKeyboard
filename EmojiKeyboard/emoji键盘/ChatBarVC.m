//
//  ChatBarVC.m
//  ChatDemo
//
//  Created by mac_111 on 16/2/29.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import "ChatBarVC.h"
#import "Header.h"
#import "ChatBarFaceView.h"


@interface ChatBarVC()<ChatbarFaceDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)ChatBarFaceView  *faceView;
@property  (nonatomic,assign)BOOL         isFaceDel;
@property (strong, nonatomic, readonly) UIViewController *rootViewController;

@property (assign, nonatomic) CGRect keyboardFrame;

@end

@implementation ChatBarVC

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithWhite:0.9 alpha:1.0];
        
        [self initTextView:frame];
        [self creatButtonToselfView:frame];
        self.isFaceDel = NO;
        

    }
    
    return self;
}

- (UIViewController *)rootViewController{
    return [[UIApplication sharedApplication] keyWindow].rootViewController;
}

// 初始化输入框
- (void)initTextView:(CGRect)frame
{
    self.textview=[[UITextView alloc]init];
    self.textview.delegate = self;
    self.textview.font = [UIFont systemFontOfSize:16];
    
    self.textview.returnKeyType = UIReturnKeySend;
    self.textLineHeight =self.textview.font.lineHeight;
    CGSize size = [self getStringRectInTextView:@"" InTextView:self.textview];
    self.textview.frame = CGRectMake(10,(frame.size.height-size.height)/2, frame.size.width-60, size.height);
    self.textview.layer.cornerRadius = 3;
    self.textview.layer.masksToBounds = YES;
    self.sendTextStr = self.textview.text;
    self.textview.layoutManager.allowsNonContiguousLayout = NO;
    
    self.textview.textColor =[UIColor blackColor];
    self.primeTextheight = self.textview.frame.size.height;
    self.textview.backgroundColor =[UIColor whiteColor];
    self.textview.scrollEnabled = NO;
    [self addSubview:self.textview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardPoHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardPoShow:) name:UIKeyboardWillShowNotification object:nil];

}

// 自定义的表情View
- (ChatBarFaceView *)faceView{
    if (!_faceView) {
        _faceView = [[ChatBarFaceView alloc]initWithFrame:CGRectMake(0, MAXHIGHT, MAXWIDTH, FunctionViewHeight) with:YES];
        _faceView.delegate = self;
        _faceView.backgroundColor = self.backgroundColor;
    }
    return _faceView;
}



- (void)cancelLocation
{
    [self.rootViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

// 键盘通知
- (void)keyBoardPoShow:(NSNotification*)pNotification
{
    self.keyboardFrame = [pNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSDictionary *userInfo = [pNotification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    keyboardRect = [self.superview convertRect:keyboardRect fromView:nil];
    // 根据老的 frame 设定新的 frame
    CGRect newTextViewFrame =self.frame; // by michael
    
    newTextViewFrame.origin.y = keyboardRect.origin.y - self.frame.size.height;
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    // 开始及执行动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    [self setViewFrame:newTextViewFrame];

    [UIView commitAnimations];
}


- (void)keyBoardPoHidden:(NSNotification*)pNotification
{
    self.keyboardFrame = CGRectZero;
    
    NSDictionary* userInfo = [pNotification userInfo];
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject =[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    CGRect newTextViewFrame = self.frame;
    
    if (self.emojiBut.selected || self.moreBut.selected) {
        
        newTextViewFrame.origin.y =MAXHIGHT - FunctionViewHeight - self.frame.size.height;
        
    }else{
        
        newTextViewFrame.origin.y = MAXHIGHT- self.frame.size.height;
    }
    
    if (self.emojiBut.selected) {
        [self setViewFrame:newTextViewFrame];
    }else{
        self.hidden = YES;
        [self setViewFrame:CGRectMake(0, MAXHIGHT-self.frame.size.height, MAXWIDTH, self.frame.size.height)];
    }
    
    
    
    
    [UIView commitAnimations];
}


/**
 
 * 主界面滑动时，对应的view变化
 */
- (void)scrollViewForChatBarView
{
    self.hidden = YES;
    if ([self.textview isFirstResponder]) {
        [self.textview resignFirstResponder];
        [self setViewFrame:CGRectMake(0, MAXHIGHT-self.frame.size.height, MAXWIDTH, self.frame.size.height)];
        
    }else if (self.emojiBut.selected){
        
        [self showFaceView:NO];
        [UIView animateWithDuration:.3 animations:^{
            [self setViewFrame:CGRectMake(0, MAXHIGHT-self.frame.size.height, MAXWIDTH, self.frame.size.height)];
            
        } completion:^(BOOL finished) {
            self.emojiBut.selected = NO;
        }];
    }
}



- (void)creatButtonToselfView:(CGRect)frame
{
    
    self.emojiBut =[UIButton buttonWithType:UIButtonTypeCustom];
    self.emojiBut.frame =CGRectMake(MAXWIDTH-40, self.frame.size.height-44, 40, 40);
    [self.emojiBut setImage:[UIImage imageNamed:@"face_press"] forState:UIControlStateNormal];
    [self.emojiBut setImage:[UIImage imageNamed:@"keyboard_press"] forState:UIControlStateSelected];
    [self.emojiBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.emojiBut.tag = ChatFunctionViewShowFace;

    [self addSubview:self.emojiBut];

}

- (void)buttonAction:(UIButton*)sender
{
    
    ChatFunctionViewShowType showType = sender.tag;

    self.emojiBut.selected = !self.emojiBut.selected;
    
    if (!sender.selected) {
        showType = ChatFunctionViewShowKeyboard;
    }
    [self showViewWithType:showType];
    
}
/**
 *  显示faceView
 *  @param show 要显示的faceView
 */

- (void)showFaceView:(BOOL)show{

    if (show) {
        [self.superview addSubview:self.faceView];
        [UIView animateWithDuration:0.25 animations:^{
            [self.faceView setFrame:CGRectMake(0, MAXHIGHT - FunctionViewHeight, MAXWIDTH, FunctionViewHeight)];
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.faceView setFrame:CGRectMake(0,MAXHIGHT, MAXWIDTH, FunctionViewHeight)];
        } completion:^(BOOL finished) {
            [self.faceView removeFromSuperview];
        }];
    }
}


- (void)showViewWithType:(ChatFunctionViewShowType)showType
{
    [self showFaceView: showType == ChatFunctionViewShowFace && self.emojiBut.selected];
    
    if (showType ==ChatFunctionViewShowKeyboard) {
        [self.textview becomeFirstResponder];
    }else if (showType == ChatFunctionViewShowFace){
        [self setViewFrame:CGRectMake(0, MAXHIGHT-FunctionViewHeight-self.bounds.size.height, MAXHIGHT, self.bounds.size.height)];
        
        [self.textview resignFirstResponder];
    }
    
}


- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView*)textView
{

    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    return adjustedSize;
    
    
    
}
-(void)faceClick:(NSString *)faceName andFaceNumber:(NSInteger)number
{
    if ([faceName isEqualToString:@"[删除]"]) {
        
        self.isFaceDel = YES;
        [self textView:self.textview shouldChangeTextInRange:NSMakeRange(self.textview.text.length - 1, 1) replacementText:@""];

        
    }else if ([faceName isEqualToString:@"[发送]"]){
        
        
        
    }else{
        
     
        
      self.textview.text = [self.textview.text stringByAppendingString:faceName];
        
      [self textViewDidChange:self.textview];
    }
}



#pragma mark -----------------------------  textView 代理方法--------------------------------------
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.emojiBut.selected = NO;
    [self showFaceView:NO];
    return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if ([text isEqualToString:@"\n"]) {
        
        
        [self sendTextMessage:textView.text];
        
        return NO;
        
    }
    //对于退格删除键开放限制
    if (text.length == 0) {
        //判断删除的文字是否符合表情文字规则
        NSString *deleteText = [textView.text substringWithRange:range];
        NSUInteger location = range.location;
        NSUInteger length = range.length;

        if ([deleteText isEqualToString:@"]"]){
                       NSString *subText;
            while (YES) {
                if (location == 0) {
                    return YES;
                }
                location -- ;
                length ++ ;
                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
                    break;
                }
            }
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
            [self textViewDidChange:self.textview];
            return NO;
        }else{
            if (self.isFaceDel ==YES) {
                NSLog(@"deleteText:%@",deleteText);
                if (textView.text.length!=0) {
                    
                    textView.text = [textView.text stringByReplacingCharactersInRange:range withString:@""];
                    [textView setSelectedRange:NSMakeRange(location, 0)];
                    [self textViewDidChange:self.textview];
                }
                
            }
            self.isFaceDel = NO;
        }
    }
    return YES;
}


- (CGFloat)bottomHeight{
    
    if (self.faceView.superview) {
        return MAX(self.keyboardFrame.size.height,self.faceView.frame.size.height);
    }else{
        return MAX(self.keyboardFrame.size.height, CGFLOAT_MIN);
    }
    
}


// 发送文本消息。

- (void)sendTextMessage:(NSString*)text
{
    if(!text || text.length ==0){
        
        return;
        
    }
    
    if (_sendBlock) {
        
        self.sendBlock(text);
        
    }
    self.textview.text = @"";
    [self textViewDidChange:self.textview];
    
    
    [self setViewFrame:CGRectMake(0,MAXHIGHT-(self.bottomHeight+48) , MAXWIDTH, 48)];
    
    
    
    
    
}





/**
 
 *  根据输入文字计算textView的大小 刷新textview 和 view；
 
 *  changBlock 回调改变聊天主界面的tableView 大小。
 */

- (void)refreshTextViewSize:(UITextView *)textView
{
    
    
    
    
    CGSize size = [self getStringRectInTextView:textView.text InTextView:textView];

    
    NSLog(@"self.textview.frame:%lf",textView.frame.size.height);
    if (textView.frame.size.height < size.height) {
        
        if (size.height<=(self.primeTextheight+3*self.textLineHeight)){
            self.textview.scrollEnabled = NO;
            NSLog(@"高度改变 刷新");
            NSLog(@"self.frame:%@",NSStringFromCGRect(self.frame));
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = textView.frame;
                textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-self.textLineHeight, self.frame.size.width,size.height+14);
                if (_changBlock) {
                    
                    self.changBlock(self.textLineHeight);
                }
            } completion:^(BOOL finished) {
                
            }];
        }else{
            self.textview.scrollEnabled = YES;
            
        }
        
    }else if(textView.frame.size.height > size.height){
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = textView.frame;
            textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.textLineHeight, self.frame.size.width,size.height+14);
            
            
        } completion:^(BOOL finished) {
            
            if (self.changBlock) {
                self.changBlock(self.textLineHeight);
            }
        }];
        
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    //    textview 改变字体的行间距
//    if (textView.text.length!=0) {
//        self.faceView.sendBtn.backgroundColor =[UIColor blueColor];
//    }else{
//        self.faceView.sendBtn.backgroundColor =[UIColor whiteColor];
//    }
    
    
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    if (selectedRange&& pos) {
        
        return;
    }

    [self refreshTextViewSize: textView];
    [self.textview scrollRangeToVisible:NSMakeRange(self.textview.text.length, 1)];
    
    
}



- (void)setViewFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    if (self.selfViewBlock) {
        
        self.selfViewBlock(frame);
        
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)setHidden:(BOOL)hidden{
    
    if (hidden) {
        [[NSNotificationCenter defaultCenter] removeObserver:self ];
        [[NSNotificationCenter defaultCenter] removeObserver:self ];
    }else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardPoHidden:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardPoShow:) name:UIKeyboardWillShowNotification object:nil];
    }
}


@end
