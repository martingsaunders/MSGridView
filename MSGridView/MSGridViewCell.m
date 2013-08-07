//
//  MSGridViewCell.m
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 TBC Digital. All rights reserved.
//

#import "MSGridViewCell.h"

@implementation MSGridViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.reuseIdentifier = identifier;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
