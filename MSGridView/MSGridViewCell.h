//
//  MSGridViewCell.h
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 TBC Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSGridViewCell : UIView <UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSString *reuseIdentifier;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier;
@end
