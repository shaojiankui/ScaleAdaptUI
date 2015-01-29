//
//  RootViewController.h
//  ScaleAdaptUI
//
//  Created by Jakey on 15/1/29.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "BaseViewController.h"
#import "AdaptUIButton.h"
@interface RootViewController : BaseViewController
{
    NSArray *_items;
    AdaptUIButton *_button;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
