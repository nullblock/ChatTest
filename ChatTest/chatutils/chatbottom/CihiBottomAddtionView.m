//
//  CihiBottomAddtionView.m
//  ChatTest
//
//  Created by null on 11/10/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomAddtionView.h"

#define COLOR(A, B, C, D) [UIColor colorWithRed:A/255.0f green:B/255.0f blue:C/255.0f alpha:D]
@implementation CihiBottomAddtionView
{
    float width;
    float height;

}
@synthesize control;

static const NSInteger MAXNUM = 4;//一行多少个

- (id)init {
    self = [super init];
    if (self) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
        height = CGRectGetHeight([UIScreen mainScreen].bounds);
        self.backgroundColor = COLOR(217, 221, 214, 1.0);
    }
    return self;
}

/*****************************************
 *  @author null, 15-11-19 09:11:40
 *
 *  @brief  商家弹出的附加面板
 *
 *  @return 面板大小
 *
 *  @since 1.0
 ****************************************/
- (CGRect)setBusinessBtnInfos {
    NSDictionary *dic = @{@"0": @{@"img": @"tool_add_gra", @"name": @"拍照"},
                          @"1": @{@"img": @"tool_add_alb", @"name": @"相册"}};
    return [self addView:dic];
}
/*****************************************
 *  @author null, 15-11-19 09:11:06
 *
 *  @brief  官方消息弹出的面板
 *
 *  @return 面板大小
 *
 *  @since 1.0
 ****************************************/
- (CGRect)setOfficialBtnInfos {
    NSDictionary *dic = @{@"0": @{@"img": @"tool_add_gra", @"name": @"拍照"},
                          @"1": @{@"img": @"tool_add_alb", @"name": @"相册"},
                          @"3": @{@"img": @"tool_add_loc", @"name": @"位置"},
                          @"4": @{@"img": @"tool_add_gif", @"name": @"礼物"}};
    return [self addView:dic];
}
/*****************************************
 *  @author null, 15-11-19 09:11:24
 *
 *  @brief  普通消息弹出的面板
 *
 *  @return 面板大小
 *
 *  @since 1.0
 ****************************************/
- (CGRect)setCustomBtnInfos {
    NSDictionary *dic = @{@"0": @{@"img": @"tool_add_gra", @"name": @"拍照"},
                          @"1": @{@"img": @"tool_add_alb", @"name": @"相册"},
                          @"2": @{@"img": @"tool_add_bur", @"name": @"隐私模式"},
                          @"3": @{@"img": @"tool_add_loc", @"name": @"位置"},
                          @"4": @{@"img": @"tool_add_gif", @"name": @"礼物"}};
      
    return [self addView:dic];
}

/*****************************************
 *  @author null, 15-11-19 09:11:12
 *
 *  @brief  根据传入参数添加相应button 并设置相应点击事件
 *
 *  @param dic
 *
 *  @return 返回面板大小
 *
 *  @since 1.0
 ****************************************/
- (CGRect)addView:(NSDictionary *)dic {
///////////////////////////////////////////////////////////////////////////////////////////////////
    float w = 60;
///////////////////////////////////////////////////////////////////////////////////////////////////
    float space = (width - w * MAXNUM) / (MAXNUM + 1);
///////////////////////////////////////////////////////////////////////////////////////////////////
    float itemx = space;
    float itemy = space;
///////////////////////////////////////////////////////////////////////////////////////////////////
    UILabel *labTXIT = nil;
///////////////////////////////////////////////////////////////////////////////////////////////////
    NSArray *array = [dic allKeys];
    array = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (((NSString *)obj1).integerValue > ((NSString *)obj2).integerValue)? NSOrderedDescending : NSOrderedAscending;
    }];
    for (NSString *str in array) {
        NSDictionary *itemDic = [dic objectForKey:str];
        
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = str.integerValue;
        btn.frame = CGRectMake(itemx, itemy, w, w);
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        [btn setImage:[UIImage imageNamed:[itemDic objectForKey:@"img"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *labinfo = [[UILabel alloc]init];
        labinfo.frame = CGRectMake(itemx, CGRectGetMaxY(btn.frame) + 5, CGRectGetWidth(btn.frame), 12);
        labinfo.font = [UIFont systemFontOfSize:12];
        labinfo.textAlignment = NSTextAlignmentCenter;
        labinfo.textColor = [UIColor blackColor];
        labinfo.text = [itemDic objectForKey:@"name"];
        [self addSubview:labinfo];
        
        if (CGRectGetMaxX(btn.frame) + space >= width) {
            itemy = CGRectGetMaxY(labinfo.frame) + space;
            itemx = space;
        } else {
            itemx = CGRectGetMaxX(btn.frame) + space;
        }
        labTXIT = labinfo;
    }
    self.frame = CGRectMake(0, 0, width, CGRectGetMaxY(labTXIT.frame) + space);

    return self.frame;
}

- (void)btnClick:(UIButton *)btn {
    [self.deleg addtionViewBtnClick:btn.tag];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
