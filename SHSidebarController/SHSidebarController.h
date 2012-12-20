//
//  SHSidebarController.h
//  Showy
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SHMenuTVC.h"
#import <UIKit/UIKit.h>

@interface SHSidebarController : UIViewController <SHMenuDelegate>
{
    BOOL                    _useOrigami;
    BOOL                    _menuOpened;
    UIView                  *behindV;
    CGRect                  _screenBounds;
    NSInteger               _current;
    NSInteger               _slideDistance;
    UITapGestureRecognizer  *_tap;
}

@property (nonatomic, strong) SHMenuTVC *menuVC;
@property (nonatomic, strong) NSArray *viewsArray;
@property (nonatomic, strong) UIViewController *mainVC;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeR;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeL;

- (id)initWithArrayOfVC:(NSArray *)array;

- (void)menuChange;
- (void)goToView:(NSInteger)index;
- (void)changeMain:(UIViewController *)main;

- (void)closeAndPop;
- (void)closeAndChange:(UIViewController *)vc;

- (void)useOrigami:(BOOL)orgigami;
- (void)setSidebarSelectionColor:(UIColor *)color;
- (void)setSideBarSlideDistance:(NSInteger)distance;

@end