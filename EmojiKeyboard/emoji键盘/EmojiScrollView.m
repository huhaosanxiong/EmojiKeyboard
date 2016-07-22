//
//  EmojiScrollView.m
//  ChatDemo
//
//  Created by mac_111 on 16/3/2.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import "EmojiScrollView.h"
#import "Header.h"
#import "NaturalData.h"
#define COUNTFORLINE  7
#define LINEFORVIEW   3
#define IMAGEWIDTH    30
@interface EmojiScrollView ()<UIScrollViewDelegate>


@property (nonatomic,strong)UIPageControl    *page;
@property (nonatomic, assign)NSInteger       pageNum;

@end
@implementation EmojiScrollView

-(id)initWithFrame:(CGRect)frame AndImageArray:(NSArray*)souceArray;
{
    self = [super initWithFrame:frame];
    
    if (self) {
//      self.backgroundColor =[UIColor redColor];
        self.scrollEnabled=YES;
        self.pagingEnabled=YES;
        self.bounces=NO;
        self.delegate=self;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.userInteractionEnabled=YES;
        self.minimumZoomScale=1;
        self.maximumZoomScale=1;
        self.decelerationRate=0.4f;
        self.backgroundColor = [UIColor clearColor];
        [self creatViewForFace:souceArray];
        
        }
    
    return self;
    
    
    
    
}


-  (void)emjiScrollBack
{
     NSLog(@"_slideBlock：%@",self.emojiDelegate);
    
    if (self.emojiDelegate &&[self.emojiDelegate respondsToSelector:@selector(emojiBackPageNumber: andIndex:)]) {
        [self.emojiDelegate emojiBackPageNumber:self.pageNum andIndex:0];
        
    }
    
}



- (void)creatViewForFace:(NSArray*)imageArray;
{
    if (imageArray.count ==0) {
        
        DLog(@"数组出错，内无值");
        
        return;
    }
   
    float  lineSpace = (self.frame.size.height -20-IMAGEWIDTH *LINEFORVIEW)/4;
    float  columnSpace =  (self.frame.size.width -IMAGEWIDTH *COUNTFORLINE)/8;
    NSInteger   onePageCount =COUNTFORLINE *LINEFORVIEW;
    
    NSInteger  page  =0;
    if (0 == imageArray.count % onePageCount) {
        page = (NSInteger) imageArray.count/onePageCount;
    }else{
        page =(NSInteger) imageArray.count/onePageCount +1;
    }
    
    self.pageNum = page;

    //灰线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH*page, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    self.contentSize = CGSizeMake(self.frame.size.width*page, self.frame.size.height);
    
    NSInteger  n = 0;
    NSString   *imageName = nil;
    for (int i = 0; i<page; i++) {
        NSInteger  pageNum = self.frame.size.width *i;
        for (int j = 0; j < onePageCount ; j++) {
            UIImageView  *image = [[UIImageView alloc]init];
            image.userInteractionEnabled = YES;
            image.frame = CGRectMake(pageNum +columnSpace +(columnSpace+IMAGEWIDTH)*(j%COUNTFORLINE) ,lineSpace+(lineSpace +IMAGEWIDTH)*(j/COUNTFORLINE) , IMAGEWIDTH, IMAGEWIDTH);

            image.tag = 1000+ n ;
            if (j == onePageCount-1) {
                imageName =[NSString stringWithFormat:@"emotion_del_normal"];
                image.image =[UIImage imageNamed:imageName];
                UITapGestureRecognizer  *delTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteTap:)];
                [image addGestureRecognizer:delTap];
            }else{
                imageName =[imageArray objectAtIndex:n];                
                UITapGestureRecognizer  *clickTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
                [image addGestureRecognizer:clickTap];
                n++;
            }
            image.image = [UIImage imageNamed:imageName];
            [self addSubview:image];
        }
    }
    
}

- (void)addPageControl;
{
    
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake((MAXWIDTH -150)/2, self.frame.size.height-20, 150, 20)];
    
    NSLog(@"=================================%@",NSStringFromCGRect(self.superview.frame));
    
    self.page.numberOfPages =self.pageNum;
    self.page.pageIndicatorTintColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
    self.page.currentPageIndicatorTintColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.superview addSubview:self.page];
 
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (scrollView == self) {
        NSInteger   index = scrollView.contentOffset.x/self.frame.size.width;
        self.page.currentPage = index;
    
    if (self.emojiDelegate &&[self.emojiDelegate respondsToSelector:@selector(emojiBackPageNumber:andIndex:)]) {
        [self.emojiDelegate emojiBackPageNumber:self.pageNum andIndex:index];
        
    }}



- (void)deleteTap:(UITapGestureRecognizer*)tap
{
    
    NSLog(@"删除");
    if (self.emojiDelegate &&[self.emojiDelegate respondsToSelector:@selector(deleteString)]) {
        
        [self.emojiDelegate deleteString];
    }
}

-(void)clickTap:(UITapGestureRecognizer*)tap
{
 
    NSLog(@"点击表情");
    NSInteger    numberFace = tap.view.tag -1000;
    NSLog(@"----------------%@",[[NaturalData shareInStance].imageFaceArray objectAtIndex:numberFace]);
    
    if (self.emojiDelegate &&[self.emojiDelegate respondsToSelector:@selector(emojiSelcet:)]) {
        
        [self.emojiDelegate emojiSelcet:numberFace];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
