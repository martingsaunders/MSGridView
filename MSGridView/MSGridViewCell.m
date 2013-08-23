//
//  MSGridViewCell.m
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 TBC Digital. All rights reserved.
//

#import "MSGridViewCell.h"
#import "MSGridView.h"
@interface MSGridViewCell()
{
    BOOL touching;
}
@end

@implementation MSGridViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.reuseIdentifier = identifier;
        self.contentView = [UIView new];
        [self addSubview:self.contentView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setFrame:CGRectMake(contentbuffer, contentbuffer, self.frame.size.width-contentbuffer*2, self.frame.size.height-contentbuffer*2)];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touching = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touching && [touches count] == 1) {
        UITouch *t = [touches anyObject];
        CGPoint p = [t locationInView:self];
        if(CGRectContainsPoint(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), p)) {
            
            
            NSIndexPath *ip = [(MSGridView *)self.superview indexPathForCell:self];
            
            if([[(MSGridView *)self.superview gridViewDelegate]respondsToSelector:@selector(didSelectCellWithIndexPath:)]) {
                
                [[(MSGridView *)self.superview gridViewDelegate] didSelectCellWithIndexPath:ip];
                
            }
        }
    }
    touching = NO;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    touching = NO;
}


@end
