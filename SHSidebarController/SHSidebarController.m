//
//  SHSidebarController.m
//  Showy
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SHSidebarController.h"
#import "SHMenuTVC.h"
#import "UIView+Origami.h"


@implementation SHSidebarController
@synthesize mainVC, menuVC, viewsArray, context, swipeR;


-(id)initWithArrayOfVC:(NSArray *)array{
    
    self = [super init];
    if (self){
        
        viewsArray = array;
        menuOpened = FALSE;
        NSMutableArray *tA = [NSMutableArray array];
        
        for (NSDictionary *dict in viewsArray){
            
        
            [tA addObject:[dict objectForKey:@"title"]];
            
    
        }
        
        self.mainVC = [[UIViewController alloc] init];
        self.menuVC = [[SHMenuTVC alloc] initWithTitlesArray:tA andDelegate:self];
        
        self.swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(open)];
        [self.swipeR setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:self.swipeR];
        
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [swipeL setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.view addGestureRecognizer:swipeL];
    }
    return self;
}

- (void)didSelectElementAtIndex:(NSInteger)index{
    
    /*if (index == current){
        
        
        [self closeAndPop];
    }
    else {*/
        
        current = index;
        UIViewController *vc = [[viewsArray objectAtIndex:index] objectForKey:@"vc"];
        [self closeAndChange:vc];
        
    //}
    
}

-(void)closeAndPop{
    
    if (menuOpened){
    [self.mainVC.view hideOrigamiTransitionWith:self.menuVC.view NumberOfFolds:1 Duration:.3 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
        
        menuOpened = !menuOpened;
        UINavigationController *nav = (UINavigationController*)self.mainVC;
        [nav popToRootViewControllerAnimated:YES];
        UIViewController *v = [nav.viewControllers objectAtIndex:0];
        v.navigationItem.leftBarButtonItem = nil;
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
        [bt setImage:[UIImage imageNamed:@"lines"] forState:UIControlStateNormal];
        [bt setContentEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        
        //[bt setBackgroundImage:[UIImage imageNamed:@"lines"] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(menuChange) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *src = [[UIBarButtonItem alloc] initWithCustomView:bt];
        
    
        
        v.navigationItem.leftBarButtonItem = src;
        self.mainVC = nav;
    }];
    }
    
}
-(void)closeAndChange:(UIViewController *)vc{
    
    
    [self.mainVC.view hideOrigamiTransitionWith:self.menuVC.view NumberOfFolds:1 Duration:.3 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
        
        menuOpened = !menuOpened;
        [self.mainVC.view removeGestureRecognizer:tap];
        [self changeMain:vc];
    }];
}
- (void)viewDidLoad
{
    
    [self changeMain:[[viewsArray objectAtIndex:0] objectForKey:@"vc"]];
    current = 0;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)changeMain:(UIViewController *)main{
    
   
    
    [self.mainVC.view removeFromSuperview];
    self.mainVC = main;
    self.mainVC.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    
    self.mainVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.menuVC.view.frame.size.height);
    UINavigationController *n = (UINavigationController *)self.mainVC;
    UIViewController *v = [n.viewControllers objectAtIndex:0];
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    [bt setImage:[UIImage imageNamed:@"lines"] forState:UIControlStateNormal];
    [bt setContentEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    //[bt setBackgroundImage:[UIImage imageNamed:@"lines"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(menuChange) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *src = [[UIBarButtonItem alloc] initWithCustomView:bt];
    
    
    v.navigationItem.leftBarButtonItem = src;
    
    
      
    
    
    
        
    [self.view addSubview:self.mainVC.view];
}
-(void)close{
    
    if (menuOpened){
        
        [self.mainVC.view hideOrigamiTransitionWith:self.menuVC.view NumberOfFolds:1 Duration:.2 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
            
            menuOpened = !menuOpened;
            [self.mainVC.view removeGestureRecognizer:tap];
        }];
    }
}

-(void)open{
    
    if (!menuOpened){
        
        self.menuVC.view.frame = CGRectMake(0, 0, 161.5, self.menuVC.view.frame.size.height);
        
        [self.mainVC.view showOrigamiTransitionWith:self.menuVC.view NumberOfFolds:1 Duration:.2 Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
            
            menuOpened = !menuOpened;
            [self.mainVC.view addGestureRecognizer:tap];
        }];
    }
}

-(void)menuChange{
    
    
    if (menuOpened){
        
        [self close];
    }
    else {
        
        [self open];
    }
}

-(void)goToView:(NSInteger)index{
    
    UIViewController *vc = [[viewsArray objectAtIndex:index] objectForKey:@"vc"];
    [self changeMain:vc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
