//
//  CihiTextView.m
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiTextView.h"

@implementation CihiTextView
{
    float h;
    NSInteger num;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        h = CGRectGetHeight(frame);
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        NSValue *sizevalue = [change objectForKey:NSKeyValueChangeNewKey];
        CGSize size = sizevalue.CGSizeValue;
            if (size.height > h) {
                if (size.height / h < 4) {
                    [self.cihiDelegate showAnimation:size.height - h];
                }
            } else if (size.height == h){
                [self.cihiDelegate showAnimation:0];
            }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentSize"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
