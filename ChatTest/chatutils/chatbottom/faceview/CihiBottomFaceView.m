//
//  CihiBottomFaceView.m
//  ChatTest
//
//  Created by null on 11/9/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomFaceView.h"
#import "SFaceView.h"
#import "BFaceView.h"


#define COLOR(a,b,c,d) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:d]
#define FACEVIEWCOLOR COLOR(216, 219, 222, 1.0)
#define FACEVIEWHEIGHT 175


@implementation CihiBottomFaceView
{
    NSMutableArray *itemarray;
    NSMutableArray *indexPicArray;
}

@synthesize control;

- (id)init {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), FACEVIEWHEIGHT)];
        itemarray = [[NSMutableArray alloc]init];
        indexPicArray = [[NSMutableArray alloc]init];
        [self getOriIndexPic];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        itemarray = [[NSMutableArray alloc]init];
        indexPicArray = [[NSMutableArray alloc]init];
        [self getOriIndexPic];
    }
    return self;
}

- (void)getOriIndexPic {
    //加载资源文件路径
    NSString *resPath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"chattoolbarimg"];
    NSString *path = [NSString stringWithFormat:@"%@/faceimg/smallfaceimg",resPath];
    
    [indexPicArray addObject:[NSString stringWithFormat:@"%@/faceimg/smallfaceimg/face_bq@3x.png",path]];
    [indexPicArray addObject:[NSString stringWithFormat:@"%@/faceimg/bigfaceimg/hxm2013@3x.png",path]];
}

//添加表情控制面板
- (void)getFaceAddtionView {
    
}

- (void)getSFaceView {
    //获取documents目录路径
    float width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    SFaceView *sf = [[SFaceView alloc]initWithFrame:CGRectMake(0, 0, width, FACEVIEWHEIGHT)];
    [itemarray addObject:sf];
    
    SFaceView *sf1 = [[SFaceView alloc]initWithFrame:CGRectMake(0, 0, width, FACEVIEWHEIGHT)];
    [itemarray addObject:sf1];
    
    BFaceView *bf1 = [[BFaceView alloc]init];
    [bf1 getBFaceView];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, FACEVIEWHEIGHT)];
    [scroll setContentSize:CGSizeMake(itemarray.count * width, FACEVIEWHEIGHT)];
    [scroll setBackgroundColor:FACEVIEWCOLOR];
    [scroll setFrame:CGRectMake(0, 0, width, FACEVIEWHEIGHT)];
    [scroll setPagingEnabled:YES];
    [scroll setDelegate:self];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    int i = 0;
    for (UIView *v in itemarray) {
        [v setFrame:CGRectMake(width*i, 0, width, FACEVIEWHEIGHT)];
        [scroll addSubview:v];
        i ++;
    }
    
    [self addSubview:scroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    int current = x / CGRectGetWidth([UIScreen mainScreen].bounds);
    NSLog(@"--->%d",current);
}


@end

