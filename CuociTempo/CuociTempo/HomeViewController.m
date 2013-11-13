//
//  HomeViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "HomeViewController.h"
#import "DataManager.h"

#import "SearchViewController.h"
#import "ViewController.h"
#import "GNWheelView.h"
#import "GNWheelViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    
    self.swipeSearch = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeSearched:)];
    [self.swipeSearch setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:self.swipeSearch];
    
}

- (IBAction)pressionePushed:(UIButton*)sender {
    
    
    //PressioneViewController *pressione = [self.storyboard instantiateViewControllerWithIdentifier:@"Pressione"];
    GNWheelViewController *wheel = [self.storyboard instantiateViewControllerWithIdentifier:@"Wheel"];
    wheel.title = [sender currentTitle];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:wheel animated:NO];
    
}
- (IBAction)microPushed:(id)sender {
    
    ViewController *typeWeel = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeWheel"];
    typeWeel.title = [sender currentTitle];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:typeWeel animated:NO];
}
- (IBAction)normalePushed:(id)sender {
    
    ViewController *typeWeel = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeWheel"];
    typeWeel.title = [sender currentTitle];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:typeWeel animated:NO];
}


//Swippa verso il basso per la ricerca
-(void)swipeSearched:(UISwipeGestureRecognizer*)sender{
    
    [UIView setAnimationDelegate:self];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	self.searchBar.transform =  CGAffineTransformMakeTranslation (0, 60);
	[UIView commitAnimations];
    
	/*CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"cancelClicked"];
     bounceAnimation.duration = 0.2;
     bounceAnimation.fromValue = [NSNumber numberWithInt:20];
     bounceAnimation.toValue = [NSNumber numberWithInt:0];
     bounceAnimation.fillMode = kCAFillModeForwards;
     bounceAnimation.removedOnCompletion = NO;
     bounceAnimation.additive = YES;
     [self.searchBar.layer addAnimation:bounceAnimation forKey:nil];*/
    [self.searchBar becomeFirstResponder];
    
}

//Metodi del SearchDisplayController
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cell.textLabel.text = @"a";
    }
    
    return cell;
}

/*- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}*/


-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{

    [UIView setAnimationDelegate:self];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	self.searchBar.transform =  CGAffineTransformMakeTranslation (0, -44);
	[UIView commitAnimations];

    [self.tableView setHidden:YES];
    [self.searchBar resignFirstResponder];
}

@end
