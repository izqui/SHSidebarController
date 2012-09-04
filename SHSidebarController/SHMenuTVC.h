//
//  MenuTVC.h
//  TVS
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SHMenuDelegate;
@interface SHMenuTVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    id <SHMenuDelegate> delegate;
    NSArray *titlesArray;
}
-(id)initWithTitlesArray:(NSArray *)array andDelegate:(id<SHMenuDelegate>)del;
@property (nonatomic, strong) UITableView *tableView;

@end
@protocol SHMenuDelegate <NSObject>
@optional

-(void)didSelectElementAtIndex:(NSInteger)index;
@end