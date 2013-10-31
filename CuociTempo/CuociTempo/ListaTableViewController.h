//
//  ListaTableViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToBack;

@end
