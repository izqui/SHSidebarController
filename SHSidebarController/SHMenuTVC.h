//
//  MenuTVC.h
//  TVS
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHMenuDelegate <NSObject>
@optional
-(void)didSelectElementAtIndex:(NSInteger)index;
@end

@protocol SHMenuDelegate;
@interface SHMenuTVC : UIViewController <UITableViewDataSource,
UITableViewDelegate>
{
    UIImageView *_sbg;
    UIImageView *_shadow;
    CGRect      _screenBounds;
    NSArray     *_titlesArray;
    UIView      *_cellSelectedBackgroundView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) id<SHMenuDelegate> delegate;

- (void)setTableViewWidth:(NSInteger)width;
- (void)setCellSelectionColor:(UIColor *)color;
- (id)initWithTitlesArray:(NSArray *)array andDelegate:(id<SHMenuDelegate>)del;

@end