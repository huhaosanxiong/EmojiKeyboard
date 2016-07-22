//
//  NaturalData.m
//  ChatDemo
//
//  Created by mac_111 on 16/2/24.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import "NaturalData.h"

@implementation NaturalData



+(NaturalData *)shareInStance
{
    static  NaturalData   *only = nil;
    static dispatch_once_t one;
    dispatch_once(&one, ^{
        only = [[self alloc]init];
        only.headImageArray =[NSArray arrayWithObjects:@"head1.jpg", @"head2.png",@"head3.jpg",@"head4.jpg",@"head5.jpg",@"head6.jpg",nil];
         only.faceArray = [[NSArray alloc]initWithObjects:@"[微笑]",@"[撇嘴]",@"[色]",@"[发呆]",@"[得意]",@"[流泪]",@"[害羞]",@"[闭嘴]",@"[睡]",@"[大哭]",@"[尴尬]",@"[发怒]",@"[调皮]",@"[呲牙]",@"[惊讶]",@"[难过]",@"[严肃]",@"[冷汗]",@"[抓狂]",@"[吐]",@"[偷笑]",@"[可爱]",@"[白眼]",@"[傲慢]",@"[饥饿]",@"[困]",@"[惊恐]",@"[流汗]",@"[憨笑]",@"[大兵]",@"[奋斗]",@"[咒骂]",@"[疑问]",@"[嘘]",@"[晕]",@"[折磨]",@"[衰]",@"[骷髅]",@"[敲打]",@"[再见]",@"[擦汗]",@"[抠鼻]",@"[鼓掌]",@"[糗大了]",@"[坏笑]",@"[左哼哼]",@"[右哼哼]",@"[哈欠]",@"[鄙视]",@"[委屈]",@"[快哭了]",@"[阴险]",@"[亲嘴]",@"[吓]",@"[可怜]",@"[菜刀]",@"[西瓜]",@"[啤酒]",@"[篮球]",@"[乒乓]",@"[咖啡]",@"[饭]",@"[猪头]",@"[玫瑰]",@"[凋谢]",@"[示爱]",@"[爱心]",@"[心碎]",@"[蛋糕]",@"[闪电]",@"[炸弹]",@"[刀]",@"[足球]",@"[瓢虫]",@"[便便]",@"[月亮]",@"[太阳]",@"[礼物]",@"[拥抱]",@"[强]",@"[弱]",@"[握手]",@"[胜利]",@"[抱拳]",@"[勾引]",@"[拳头]",@"[差劲]",@"[爱你]",@"[NO]",@"[OK]",@"[爱情]",@"[飞吻]",@"[跳跳]",@"[发抖]",@"[怄火]",@"[转圈]",@"[磕头]",@"[回头]",@"[跳绳]",@"[挥手]",@"[激动]",@"[街舞]",@"[献吻]",@"[左太极]",@"[右太极]",@"[小女孩]",@"[人民币]",@"[招财猫]",@"[双喜]",@"[鞭炮]",@"[灯笼]",@"[发财]",@"[K歌]",@"[购物]",@"[邮件]",@"[帅]",@"[喝彩]",@"[祈祷]",@"[爆筋]",@"[棒棒糖]",@"[喝奶]",@"[下面]",@"[香蕉]",@"[飞机]",@"[开车]",@"[左车头]",@"[车厢]",@"[右车头]",@"[多云]",@"[下雨]",@"[钞票]",@"[熊猫]",@"[灯泡]",@"[风车]",@"[闹钟]",@"[雨伞]",@"[气球]",@"[钻戒]",@"[沙发]",@"[纸巾]",nil];   //,@"[胶囊]",@"[手枪]",@"[青蛙]"
         only.gifFaceArray = [[NSArray alloc]initWithObjects:@"微笑",@"无视",@"尴尬",@"心碎",@"叹气",@"发怒",@"惊讶",@"奋斗",@"难过",@"再见",@"吃饭",@"坏笑",@"晕",@"害羞",@"闭嘴",@"疑问",@"烧香",@"色",@"耍酷",@"砸砖",@"流泪",@"流汗",@"目瞪口呆",@"委屈",nil];
        only.imageFaceArray = [NSMutableArray array];
        for (int i=0; i<only.faceArray.count; i++) {
            NSString *str = [NSString stringWithFormat:@"f_%.3d.png", i];
            [only.imageFaceArray addObject:str];
        }
        
        only.gifImageArray =[NSMutableArray array];
        for (int i=0; i<only.gifFaceArray.count; i++) {
            NSString *str = [NSString stringWithFormat:@"l_%.3d.png", i];
            [only.gifImageArray addObject:str];
        }
        
        only.moreViewTitle = [NSArray arrayWithObjects:@"照片",@"拍摄",@"语音聊天",@"个人名片",@"位置",nil];
        only.moreImageStr =[NSArray arrayWithObjects:@"sharemore_1",@"sharemore_2",@"sharemore_3",@"sharemore_4",@"sharemore_5",nil];
        
        
        
        
        
        
    });
    
    return only;
}
@end
