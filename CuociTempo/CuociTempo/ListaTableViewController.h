//
//  ListaTableViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerViewController.h"

@interface ListaTableViewController : UITableViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToBack;
@property (strong,nonatomic) TimerViewController *timer;
@end