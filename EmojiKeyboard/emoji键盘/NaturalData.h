//
//  NaturalData.h
//  ChatDemo
//
//  Created by mac_111 on 16/2/24.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NaturalData : NSObject


@property (nonatomic,strong ) NSArray        *headImageArray;
@property (nonatomic,copy   ) NSString       *name;
@property (nonatomic,strong ) NSArray        *faceArray;
@property (nonatomic,strong ) NSString       *DKLArray;
@property (nonatomic,strong ) NSMutableArray *imageFaceArray;

@property (nonatomic, strong) NSMutableArray *gifImageArray;
@property (nonatomic, strong) NSArray        *gifFaceArray;
@property (nonatomic, strong) NSArray        *moreViewTitle;
@property (nonatomic,strong ) NSArray        *moreImageStr;


+(NaturalData *)shareInStance;




@end
