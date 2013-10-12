//
//  SearchViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 09/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToBack;

@end
