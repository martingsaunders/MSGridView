//
//  RootViewController.m
//  MSGridView
//
//  Created by Martin Saunders on 07/08/2013.
//  Copyright (c) 2013 Martin Saunders. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MSGridView *gridView = [[MSGridView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    gridView.gridViewDelegate = self;
    gridView.gridViewDataSource = self;
    [gridView setInnerSpacing:CGSizeMake(100, 0)];
    [self.view addSubview:gridView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark gridView delegate methods

#pragma mark gridView datasource methods


-(MSGridViewCell *)cellForIndexPath:(NSIndexPath*)indexPath inGridWithIndexPath:(NSIndexPath *)gridIndexPath;
{
    
    static NSString *reuseIdentifier = @"cell";
    MSGridViewCell *cell = [MSGridView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil) {
        cell = [[MSGridViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
    }
    
    

     cell.backgroundColor = [UIColor colorWithHue:([indexPath indexAtPosition:0]*3+[indexPath indexAtPosition:1])/9.0f saturation:1 brightness:1 alpha:1];
    
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1;
    return cell;
    
}

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridRows
{
    return 1;
}

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridColumns
{
    return 100;
}


-(NSUInteger)numberOfColumnsForGridAtIndexPath:(NSIndexPath*)indexPath
{
   
    return 3;
}

-(NSUInteger)numberOfRowsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    return 3;
}


@end
