//
//  HomeViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeSearch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *pressioneButton;
@property (weak, nonatomic) IBOutlet UIButton *microButton;
@property (weak, nonatomic) IBOutlet UIButton *normaleButton;

@end
