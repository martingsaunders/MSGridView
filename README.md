MSGridView
==========

A grid of grids iOS component with cell recycling equivalent to a UITableView

Installation
------------

Copy MSGridView.h, MSGridView.m, MSGridViewCell.h and MSGridViewCell.m into your project.

Usage
-----

In your view controller (e.g. in viewDidLoad) initialise and add the view

    MSGridView *gridView = [[MSGridView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:gridView];
    
Then you need to setup delegate and datasource

    gridView.gridViewDelegate = self;
    gridView.gridViewDataSource = self;
    
From there you can set a few parameters:

Paging - by default this is on. Disable with:

    self.pagingEnabled = NO;
    
Inner spacing (gaps between grids):

    [gridView setInnerSpacing:CGSizeMake(100, 100)];


Delegate / DataSource methods
-----------------------------

See MSGridView.h but...

Required Datasource methods:

    // returns the cell for a specific grid row/column, row/column set
    -(MSGridViewCell *)cellForIndexPath:(NSIndexPath*)indexPath inGridWithIndexPath:(NSIndexPath *)gridIndexPath;
     
    // Returns the number of supergrid rows
    -(NSUInteger)numberOfGridRows;
     
    // Returns the number of supergrid rows
    -(NSUInteger)numberOfGridColumns;
    
All basically the same as a UITableView

Option methods:

    // for each given super grid, how many rows do we have? Default 1
    -(NSUInteger)numberOfRowsForGridAtIndexPath:(NSIndexPath *)indexPath;
     
    // for each given super grid, how many columns do we have? Default 1
    -(NSUInteger)numberOfColumnsForGridAtIndexPath:(NSIndexPath *)indexPath;
     
    // the size of an individual grid cell row / column. Default is the view width / number rows or columns
    -(float)heightForCellRowAtIndex:(NSUInteger)row forGridAtIndexPath:(NSIndexPath *)gridIndexPath;
    -(float)widthForCellColumnAtIndex:(NSUInteger)column forGridAtIndexPath:(NSIndexPath *)gridIndexPath;
    
Custom MSGridViewCells

Just subclass MSGridViewCell and modify in the same way as a custom UIViewCell. At current this is just an empty UIView so there are no default labels etc.

Demo
----

Run the XCodeProject
