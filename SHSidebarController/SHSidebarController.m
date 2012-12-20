//
//  SHSidebarController.m
//  Showy
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+Origami.h"
#import "SHSidebarController.h"

@implementation SHSidebarController

#pragma mark - Initialization

- (id)initWithArrayOfVC:(NSArray *)array
{
    self = [super init];
    if (self) {
        _viewsArray = array;
        _screenBounds = [[UIScreen mainScreen] bounds];
        
        _menuOpened = FALSE;
        NSMutableArray *tA = [NSMutableArray array];
        
        for (NSDictionary *dict in _viewsArray) {
            [tA addObject:[dict objectForKey:@"title"]];
        }
        
        self.mainVC = [[UIViewController alloc] init];
        self.menuVC = [[SHMenuTVC alloc] initWithTitlesArray:tA andDelegate:self];
        self.swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(open)];
        [self.swipeR setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:self.swipeR];
        
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        _swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_swipeL setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.view addGestureRecognizer:_swipeL];
        
        // Use Origami By Default
        _useOrigami = YES;
    }
    return self;
}

#pragma mark - Set Sidebar Selection Color

- (void)setSidebarSelectionColor:(UIColor *)color
{
    [self.menuVC setCellSelectionColor:color];
}

#pragma mark - Set Sidebar Slide Distance

- (void)setSideBarSlideDistance:(NSInteger)distance
{
    _slideDistance = distance;
    [self.menuVC setTableViewWidth:distance];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeMain:[[_viewsArray objectAtIndex:0] objectForKey:@"vc"]];
    
    _current = 0;
}

#pragma mark - UITableView Delegate

- (void)didSelectElementAtIndex:(NSInteger)index
{
    _current = index;
    UIViewController *vc = [[_viewsArray objectAtIndex:index] objectForKey:@"vc"];
    [self closeAndChange:vc];
}

#pragma mark - Close And Pop

- (void)closeAndPop
{
    if (_menuOpened) {
        [self.mainVC.view hideOrigamiTransitionWith:self.menuVC.view NumberOfFolds:1 Duration:.3 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished)
         {
             _menuOpened = !_menuOpened;
             UINavigationController *nav = (UINavigationController*)self.mainVC;
             [nav popToRootViewControllerAnimated:YES];
             UIViewController *v = [nav.viewControllers objectAtIndex:0];
             v.navigationItem.leftBarButtonItem = nil;
             UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
             [bt setImage:[UIImage imageNamed:@"lines"] forState:UIControlStateNormal];
             [bt setContentEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
             
             [bt addTarget:self action:@selector(menuChange) forControlEvents:UIControlEventTouchUpInside];
             UIBarButtonItem *src = [[UIBarButtonItem alloc] initWithCustomView:bt];
             v.navigationItem.leftBarButtonItem = src;
             self.mainVC = nav;
         }];
    }
}

#pragma mark - Close And Change

- (void)closeAndChange:(UIViewController *)vc
{
    if (!_useOrigami) {
        [self changeMain:vc];
        [self close];
    } else {
        [self changeMain:vc];
        [self.mainVC.view hideOrigamiTransitionWith:self.menuVC.view NumberOfFolds:1 Duration:.3 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished)
         {
             _menuOpened = !_menuOpened;
             [self.mainVC.view removeGestureRecognizer:_tap];
         }];
    }
}

#pragma mark - Change Main

- (void)changeMain:(UIViewController *)main
{
    UINavigationController *n = (UINavigationController *)main;
    UIViewController *v = [n.viewControllers objectAtIndex:0];
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    [bt setImage:[UIImage imageNamed:@"lines"] forState:UIControlStateNormal];
    [bt setContentEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    [bt addTarget:self action:@selector(menuChange) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *src = [[UIBarButtonItem alloc] initWithCustomView:bt];
    v.navigationItem.leftBarButtonItem = src;
    
    CGRect tempFrame = self.mainVC.view.frame;
    [self.mainVC.view removeFromSuperview];
    self.mainVC = n;
    
    self.mainVC.view.frame = CGRectMake(tempFrame.origin.x, 0, _screenBounds.size.width, _screenBounds.size.height - 20.f);
    [self.view addSubview:self.mainVC.view];
}

#pragma mark - Open/Close

- (void)open
{
    if (!_menuOpened) {
        self.menuVC.view.frame = CGRectMake(0,
                                            0,
                                            (_slideDistance) ? _slideDistance : 161.5,
                                            _screenBounds.size.height - 20.f);
        if (!_useOrigami) {
            [[self.mainVC.view superview] insertSubview:self.menuVC.view belowSubview:self.mainVC.view];
            
            [UIView animateWithDuration:.3f animations:^{
                CGRect tempframe = self.mainVC.view.frame;
                tempframe.origin.x = (_slideDistance) ? _slideDistance : 161.5;
                self.mainVC.view.frame = tempframe;
            } completion:^(BOOL finished) {
                _menuOpened = !_menuOpened;
                [self.mainVC.view addGestureRecognizer:_tap];
            }];
        } else {
            int numberOfFolds = (_slideDistance > _screenBounds.size.width/2) ? 2 : 1;
            [self.mainVC.view showOrigamiTransitionWith:self.menuVC.view NumberOfFolds:numberOfFolds Duration:.4 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished)
             {
                 _menuOpened = !_menuOpened;
                 [self.mainVC.view addGestureRecognizer:_tap];
             }];
        }
    }
}

- (void)close
{
    if (_menuOpened) {
        if (!_useOrigami) {
            [UIView animateWithDuration:.3f animations:^{
                CGRect tempframe = self.mainVC.view.frame;
                tempframe.origin.x = 0.f;
                self.mainVC.view.frame = tempframe;
            } completion:^(BOOL finished) {
                _menuOpened = !_menuOpened;
                [self.mainVC.view removeGestureRecognizer:_tap];
                [self.menuVC.view removeFromSuperview];
            }];
        } else {
            int numberOfFolds = (_slideDistance > _screenBounds.size.width/2) ? 2 : 1;
            [self.mainVC.view hideOrigamiTransitionWith:self.menuVC.view NumberOfFolds:numberOfFolds Duration:.4 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished)
             {
                 _menuOpened = !_menuOpened;
                 [self.mainVC.view removeGestureRecognizer:_tap];
             }];
        }
    }
}

#pragma mark - Menu Change

- (void)menuChange
{
    if (_menuOpened) {
        [self close];
    } else {
        [self open];
    }
}

#pragma mark - Go To View

- (void)goToView:(NSInteger)index
{
    UIViewController *vc = [[_viewsArray objectAtIndex:index] objectForKey:@"vc"];
    [self changeMain:vc];
}

#pragma mark - Use Origami

- (void)useOrigami:(BOOL)orgigami;
{
    _useOrigami = orgigami;
}

@end