//
//  MenuTVC.m
//  TVS
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SHMenuTVC.h"
#import <QuartzCore/QuartzCore.h>

@implementation SHMenuTVC

#pragma mark - Initialization

- (id)initWithTitlesArray:(NSArray *)array andDelegate:(id<SHMenuDelegate>)del
{
    self = [super init];
    if (self) {
        _delegate = del;
        _titlesArray = array;
        _screenBounds = [[UIScreen mainScreen] bounds];
        
        self.view.frame = CGRectMake(0, 0, 161.5, _screenBounds.size.height);
    }
    return self;
}

#pragma mark - View Did Load

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   162,
                                                                   _screenBounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarshadow"]];
    [_shadow setFrame:CGRectMake(118, 0, 43.5, _screenBounds.size.height)];
    [self.view addSubview:_shadow];
    
    _sbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarbg"]];
    [_sbg setFrame:CGRectMake(0, 0, 161.5, _screenBounds.size.height)];
    [self.tableView setBackgroundView:_sbg];
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"sideBarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set Selection Color
    if (_cellSelectedBackgroundView) {
        [cell setSelectedBackgroundView:_cellSelectedBackgroundView];
    }
    
    cell.textLabel.text = [_titlesArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]];
    [bg setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 42.5)];
    cell.backgroundView = bg;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectElementAtIndex:)]) {
        [_delegate didSelectElementAtIndex:indexPath.row];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - Set Cell Selection Color

- (void)setCellSelectionColor:(UIColor *)color
{
    // Set Background Color For Selected Cells
    _cellSelectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellSelectedBackgroundView.backgroundColor = color;
}

#pragma mark - Set TableView Width

- (void)setTableViewWidth:(NSInteger)width
{
    // Reset All UI Objects For New Width
    self.view.frame = CGRectMake(0, 0, width - 0.5f, _screenBounds.size.height);
    self.tableView.frame = CGRectMake(0, 0, width, _screenBounds.size.height);
    [_sbg setFrame:CGRectMake(0, 0, width - 0.5f, _screenBounds.size.height)];
    [_shadow setFrame:CGRectMake(width - 43.5f, 0, 43.5, _screenBounds.size.height)];
}

@end