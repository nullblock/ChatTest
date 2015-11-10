//
//  CihiBottomAddtionView.m
//  ChatTest
//
//  Created by null on 11/9/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomAddtionView.h"

@implementation CihiBottomAddtionView
{
    
}

@synthesize control;

- (id)init {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 253)];
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

@end
