//
//  PesoViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 10/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PesoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToBack;
@property (assign,nonatomic)NSString* cottura;
@end
