//
//  ViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 10/11/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DataManager.h"
#import "Tipo.h"
#import "GNWheelViewController.h"


@implementation ViewController

@synthesize pieChartRight = _pieChart;
@synthesize selectedSliceLabel = _selectedSlice;
@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;
int num;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    num = [[DataManager sharedClass]numerodiEntita:@"Tipo" sezione:0 predicate:[NSString stringWithFormat:@"(0 != SUBQUERY(alimentos, $x, (0 != SUBQUERY($x.cotturas, $y, $y.type == '%@'))))",self.title]];
    
    self.slices = [NSMutableArray arrayWithCapacity:num];
    
    for(int i = 0; i < 5; i ++)
    {
        [_slices addObject:[NSNumber numberWithInt:1]];
    }
    
    [self.pieChartRight setDelegate:self];
    [self.pieChartRight setDataSource:self];
    [self.pieChartRight setPieCenter:CGPointMake(self.pieChartRight.center.x, self.pieChartRight.center.y-50)];
    [self.pieChartRight setShowPercentage:NO];
    [self.pieChartRight setLabelColor:[UIColor blackColor]];

    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    //rotate up arrow
}

- (void)viewDidUnload
{
    [self setPieChartRight:nil];
    [self setSelectedSliceLabel:nil];

    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChartRight reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

/*- (IBAction)clearSlices {
    [_slices removeAllObjects];
    [self.pieChartRight reloadData];
}*/


/*- (IBAction)updateSlices
{
    for(int i = 0; i < _slices.count; i ++)
    {
        [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:rand()%60+20]];
    }
    [self.pieChartRight reloadData];
}*/

/*- (IBAction)showSlicePercentage:(id)sender {
    UISwitch *perSwitch = (UISwitch *)sender;
    [self.pieChartRight setShowPercentage:perSwitch.isOn];
}*/

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return 1;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
    self.selectedSliceLabel.text = [self pieChart:pieChart textForSliceAtIndex:index];
    GNWheelViewController *wheel = [self.storyboard instantiateViewControllerWithIdentifier:@"Wheel"];
    wheel.title = self.selectedSliceLabel.text;
    [self.navigationController pushViewController:wheel animated:NO];
}

-(NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index{
    Tipo *tipo = (Tipo*)[[DataManager sharedClass]fetchRequestPerCella:@"Tipo"
                                                                  cell:index
                                                      predicate:[NSString stringWithFormat:@"(0 != SUBQUERY(alimentos, $x, (0 != SUBQUERY($x.cotturas, $y, $y.type == '%@'))))",self.title]];
    return tipo.nametype;
}

-(void)swipeToHome:(XYPieChart *)pieChart{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
@end
