//
//  CihiBottomAudioView.h
//  ChatTest
//
//  Created by null on 11/7/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CihiBottomAudioView : UIView <UIScrollViewDelegate>
{
    UIImageView *_audioimg;
    UIImageView *_redPoint;
    UILabel *_labInfo;
}
@property (nonatomic, assign) UIViewController *control; //添加的界面

@property (nonatomic, strong) UIImageView *audioimg;
@property (nonatomic, strong) UIImageView *redPoint;
@property (nonatomic, strong) UILabel *labInfo;

- (void)addview;
- (void)addLongPressGesture;
- (void)addTapPressGesture;

- (void)addPageControlView;

- (void)addAllScroller;
@end
