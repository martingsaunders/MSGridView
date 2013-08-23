//
//  MSInfiniteGridView.h
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 Martin Saunders. All rights reserved.
//  www.martingsaunders.com
//

#import <UIKit/UIKit.h>
#import "MSGridViewCell.h"

@protocol MSGridViewDataSource <NSObject>
@required
// returns the cell for a specific grid row/column, row/column set
-(MSGridViewCell *)cellForIndexPath:(NSIndexPath*)indexPath inGridWithIndexPath:(NSIndexPath *)gridIndexPath;

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridRows;

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridColumns;

@optional
// for each given super grid, how many rows do we have?
-(NSUInteger)numberOfRowsForGridAtIndexPath:(NSIndexPath *)indexPath;

// for each given super grid, how many columns do we have?
-(NSUInteger)numberOfColumnsForGridAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol MSGridViewDelegate <NSObject>

@optional

// the size of an individual grid cell
-(float)heightForCellRowAtIndex:(NSUInteger)row forGridAtIndexPath:(NSIndexPath *)gridIndexPath;
-(float)widthForCellColumnAtIndex:(NSUInteger)column forGridAtIndexPath:(NSIndexPath *)gridIndexPath;
-(void)didSelectCellWithIndexPath:(NSIndexPath*) indexPath;

@end



@interface MSGridView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic,weak) id <MSGridViewDelegate> gridViewDelegate;
@property (nonatomic,weak) id <MSGridViewDataSource> gridViewDataSource;
-(void)setInnerSpacing:(CGSize)innerSpacing;
-(void)reloadData;
-(NSIndexPath *)indexPathForCell:(MSGridViewCell *)cell;
+(MSGridViewCell *)dequeueReusableCellWithIdentifier:(NSString *)CellIdentifier;
@end
