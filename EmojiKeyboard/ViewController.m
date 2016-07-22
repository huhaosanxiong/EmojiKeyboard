//
//  ViewController.m
//  EmojiKeyboard
//
//  Created by mac-333 on 16/7/22.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import "ViewController.h"
#import "ChatBarVC.h"
#import "Header.h"
#import "NSString+HNEmojiExtension.h"


@interface ViewController ()
@property (nonatomic,strong ) ChatBarVC       *footVc; //输入框view
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //用来接收收起键盘的view , 可加可不加
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH, MAXHIGHT-self.footVc.frame.size.height)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickScreen)];
    [bgView addGestureRecognizer:tap];
    [self.view addSubview:bgView];
    
}
/**
 *  @author hhsx, 16-07-10 15:40:41
 *
 *  输入内容
 */
- (IBAction)sendMessage:(id)sender {
    [self.view addSubview:self.footVc];
    _footVc.hidden = NO;
    [self footVcBlocks];
    [_footVc.textview becomeFirstResponder];
}
/**
 *  @author hhsx, 16-07-10 11:30:15
 *
 *  点击屏幕收起键盘
 */
- (void)clickScreen
{
    [_footVc scrollViewForChatBarView];
    [_footVc removeFromSuperview];
}


/**
 *  @author hhsx, 16-07-08 16:20:16
 *
 *  输入框的回调
 */
- (void)footVcBlocks
{
    @weakify(self);
    self.footVc.sendBlock = ^(NSString *text){
        @strongify(self);
        DLog(@"%@",text);
        
        NSAttributedString *labelAttributed = [text emotionStringWithEmojiHeight:15];
        
        self.textView.attributedText = labelAttributed;
        
        //重新计算高度
        NSRange range = NSMakeRange(0, labelAttributed.length);
        NSDictionary *dic = [labelAttributed attributesAtIndex:0 effectiveRange:&range];
        
        CGSize textRealSize = [self getStringRectInTextView:text AndAttributedString:dic InTextView:self.textView];
        
        self.textView.frame = CGRectMake(20, 86, MAXWIDTH-20*2, textRealSize.height);
    };
    self.footVc.selfViewBlock = ^(CGRect frame){
        @strongify(self);
        NSLog(@"改变后的View的Frame----%@",NSStringFromCGRect(frame));
        CGFloat   tableMainY =  CGRectGetMinY(frame);
        [UIView  animateWithDuration:0.3 animations:^{
            
            //这里处理tableview的高度
            
        } completion:^(BOOL finished) {
            
        }];
    };
}

- (CGSize)getStringRectInTextView:(NSString *)string AndAttributedString:(NSDictionary *)dic InTextView:(UITextView*)textView
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
//    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    return adjustedSize;
}


- (ChatBarVC *)footVc{
    
    return FTD_LAZY(_footVc, ({
        ChatBarVC *vc = [[ChatBarVC alloc]initWithFrame:CGRectMake(0, MAXHIGHT-48, MAXWIDTH, 48)];
        vc;
    }));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
