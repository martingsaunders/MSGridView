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
    self.pagingEnabled = YES;
    

    
    
