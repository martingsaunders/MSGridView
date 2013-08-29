//
//  MSInfiniteGridView.m
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 Martin Saunders. All rights reserved.
//  www.martingsaunders.com
//

#import "MSGridView.h"


@interface MSGridView()
{
    int gridRows;
    int gridColumns;
    NSMutableDictionary *gridCells;
    CGSize innerSpacing;
    
}

@end

@implementation MSGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // basic grid properties
        gridRows = 1;
        gridColumns = 1;
        // (number of super grids = gridRows x gridColumns)
        
        self.delegate = self;
        
        gridCells = [NSMutableDictionary dictionary];
        
        
        
        self.pagingEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
         [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    }
    return self;
}

-(void)reloadData
{
    
    [self layoutSubviews];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // basic grid properties
    if([self.gridViewDataSource respondsToSelector:@selector(numberOfGridRows)])
        gridRows = [self.gridViewDataSource numberOfGridRows];
    
    if([self.gridViewDataSource respondsToSelector:@selector(numberOfGridColumns)])
        gridColumns = [self.gridViewDataSource numberOfGridColumns];
    
    
    
    // which cell are we looking at
    
    CGPoint viewCenter;
    viewCenter.x = [self contentOffset].x+(self.frame.size.width + innerSpacing.width)/2;
    viewCenter.y = [self contentOffset].y+(self.frame.size.height + innerSpacing.height)/2;
    
    //NSLog(@"View Center: %f,%f. Num cells: %i",viewCenter.x,viewCenter.y,[gridCells count]);
    
    // loop through super grids and add cells to grids array
    
    // current grid indexpath
    
    NSUInteger currIntArray[] = {floor(viewCenter.y/self.frame.size.height),floor(viewCenter.x/self.frame.size.width)};
    NSIndexPath *currentGridIndexPath = [NSIndexPath indexPathWithIndexes:currIntArray length:2];
    
   // NSLog(@"current grid: %@",currentGridIndexPath);
    // loop through gridCells and remove / queue not allowed cells
    NSArray *a = [gridCells allKeys];
    
    int minGridRow = [currentGridIndexPath indexAtPosition:0]-1;
    int maxGridRow = [currentGridIndexPath indexAtPosition:0]+1;
    int minGridColumn = [currentGridIndexPath indexAtPosition:1]-1;
    int maxGridColumn = [currentGridIndexPath indexAtPosition:1]+1;
    for(NSIndexPath *ip in a) {
        
        // row
        if((int)[ip indexAtPosition:0] < minGridRow ||
           (int)[ip indexAtPosition:0] > maxGridRow ||
           (int)[ip indexAtPosition:1] < minGridColumn ||
           (int)[ip indexAtPosition:1] > maxGridColumn
           ) {
            MSGridViewCell *cell = [gridCells objectForKey:ip];
            [cell removeFromSuperview];
            [self.class queueCell:cell];
            [gridCells removeObjectForKey:ip];
        }
    }
    
    
    
    
    
    // just the ones we want
    for(int r=MAX(0,minGridRow);r<MIN(gridRows,maxGridRow+1);r++) {
        
        for(int c=MAX(0,minGridColumn);c<MIN(gridColumns,maxGridColumn+1);c++) {
            
            // and now the cells
            
            NSUInteger gridIntegerArray[] = {r,c};
            NSIndexPath *gridIndexPath = [NSIndexPath indexPathWithIndexes:gridIntegerArray length:2];
            
            // number of sub grid rows
            int subGridRows = 1;
            if([self.gridViewDataSource respondsToSelector:@selector(numberOfRowsForGridAtIndexPath:)])
            {
                subGridRows = [self.gridViewDataSource numberOfRowsForGridAtIndexPath:gridIndexPath];
            }
            
            // number of sub grid columns
            int subGridCols = 1;
            if([self.gridViewDataSource respondsToSelector:@selector(numberOfColumnsForGridAtIndexPath:)])
            {
                subGridCols = [self.gridViewDataSource numberOfColumnsForGridAtIndexPath:gridIndexPath];
            }
            
            
            
            for(int sr = 0;sr<subGridRows;sr++) {
                
                for(int sc = 0;sc<subGridCols;sc++) {
                    
                    NSUInteger cellIntegerArray[] = {sr,sc};
                    NSIndexPath *cellIndexPath = [NSIndexPath indexPathWithIndexes:cellIntegerArray length:2];
                    
                    
                    
                    // cell width
                    
                    float w = (self.frame.size.width -innerSpacing.width)/(float)subGridCols;
                    if([self.gridViewDelegate respondsToSelector:@selector(widthForCellColumnAtIndexPath:forGridAtIndexPath:)]) {
                        w = [self.gridViewDelegate widthForCellColumnAtIndex:sc forGridAtIndexPath:gridIndexPath];
                    }
                    
                    //                    cell height
                    
                    float h = (self.frame.size.height-innerSpacing.height)/subGridCols;
                    if([self.gridViewDelegate respondsToSelector:@selector(heightForCellRowAtIndex:forGridAtIndexPath:)]) {
                     
                        h = [self.gridViewDelegate heightForCellRowAtIndex:sr forGridAtIndexPath:gridIndexPath];
                    }
                    
                    float x = c*self.frame.size.width+w*sc+innerSpacing.width/2 ;
                    float y = r*self.frame.size.height + h*sr+innerSpacing.height/2;
                    
                    if(x+w/2 > viewCenter.x-self.frame.size.width &&
                       x+w/2 < viewCenter.x+self.frame.size.width &&
                       y+h/2 > viewCenter.y-self.frame.size.height &&
                       y+h/2 < viewCenter.y+self.frame.size.height) {
                        
                        // create cell
                        MSGridViewCell *cell = [self.gridViewDataSource cellForIndexPath:cellIndexPath inGridWithIndexPath:gridIndexPath];
                        
                        if(cell != nil) {
                            [cell setFrame:CGRectMake(x,y , w, h)];
                            
                            [self.class queueCell:cell];
                            
                            
                            
                            
                            
                            if([[[self.class reuseQueue] objectForKey:cell.reuseIdentifier ] containsObject:cell])
                            {
                                [[[self.class reuseQueue] objectForKey:cell.reuseIdentifier ] removeObject:cell];
                            }
                            
                            NSUInteger bigIntArray[] = {r,c,sr,sc};
                            NSIndexPath *bigIndexPath = [NSIndexPath indexPathWithIndexes:bigIntArray length:4];
                            
                            // big index path
                            if([gridCells objectForKey:bigIndexPath] == nil) {
                                //cell.frame = ...;
                                [gridCells setObject:cell forKey:bigIndexPath];
                                [self addSubview:cell];
                            }
                        }
                    }
                    
                }
                
                
                
            }
            
        }
        
    }
    
    
    
#if DEBUG
   // NSLog(@"cols: %i, rows: %i",gridColumns,gridRows);
   // NSLog(@"number of real cells: %i",[gridCells count]);
   // NSLog(@"queue length: %i",[[[self.class reuseQueue] objectForKey:@"cell" ] count]);
#endif
    
    [self setContentSize:CGSizeMake(self.frame.size.width*gridColumns, self.frame.size.height * gridRows)];
    
    
    
}

-(void)setInnerSpacing:(CGSize)innerSpace
{
    
    innerSpacing = innerSpace;
    
    CGRect f = self.frame;
    f.origin.x -= innerSpacing.width/2;
    f.size.width += innerSpacing.width;
    f.origin.y -= innerSpacing.height/2;
    f.size.height   += innerSpacing.height;
    
    self.frame = f;
    
    
}

+(void)queueCell:(MSGridViewCell *)cell
{
    if([[self reuseQueue] objectForKey:cell.reuseIdentifier] == nil)
    {
        NSMutableArray *a = [NSMutableArray arrayWithObject: cell];
        [[self reuseQueue] setObject:a forKey:cell.reuseIdentifier];
        
    }
    [(NSMutableArray *)[[self reuseQueue] objectForKey:cell.reuseIdentifier] addObject:cell];
}


+(NSMutableDictionary *)reuseQueue
{
    static NSMutableDictionary *reuseQueue;
    if(reuseQueue == nil) {
        reuseQueue = [NSMutableDictionary dictionary];
    }
    return reuseQueue;
}


+(MSGridViewCell *)dequeueReusableCellWithIdentifier:(NSString *)CellIdentifier
{
    // check for a spare cell with this identifier and return
    
    if([[self reuseQueue] objectForKey:CellIdentifier] != nil && [(NSArray *)[[self reuseQueue] objectForKey:CellIdentifier] count] > 0) {
        return [(NSArray *)[[self reuseQueue] objectForKey:CellIdentifier] lastObject];
    }
    return nil;
}

-(void)deviceOrientationDidChange:(NSNotification *)notification
{
    
    if(self.pagingEnabled) {
        CGPoint viewCenter;
        viewCenter.x = [self contentOffset].x+(self.frame.size.width + innerSpacing.width)/2;
        viewCenter.y = [self contentOffset].y+(self.frame.size.height + innerSpacing.height)/2;
        
        [self setContentOffset:CGPointMake(floor(viewCenter.x/self.frame.size.width)*self.frame.size.width, floor(viewCenter.y/self.frame.size.height)*self.frame.size.height) animated:NO];
        
        
    }
}

-(NSIndexPath *)indexPathForCell:(MSGridViewCell *)cell
{
    return [[gridCells allKeysForObject:cell] lastObject];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
