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

#define DegreesToRadians(x) (M_PI * x / 180.0)

@implementation ViewController

@synthesize pieChartRight = _pieChart;
@synthesize selectedSliceLabel = _selectedSlice;
@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;
@synthesize fetchObject = _fetchObject;

int num;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    NSLog(@"title %@",self.title);
    
    [super viewDidLoad];

    self.fetchObject = [[DataManager sharedClass]fetchaRequest:@"Tipo" predicate:[NSString stringWithFormat:@"(0 != SUBQUERY(alimentos, $x, (0 != SUBQUERY($x.cotturas, $y, $y.type == '%@'))))",self.title]];
    
    num = [[DataManager sharedClass]numerodiEntitaFromFetch:self.fetchObject sezione:0];
    
    self.slices = [NSMutableArray arrayWithCapacity:num];
    
    for(int i = 0; i < num; i ++)
    {
        [_slices addObject:[NSNumber numberWithInt:num]];
    }
    
    [self.pieChartRight setDataSource:self];
    [self.pieChartRight setStartPieAngle:M_PI_2];
    [self.pieChartRight setAnimationSpeed:1.0];
    [self.pieChartRight setLabelRadius:100];
    [self.pieChartRight setShowPercentage:YES];
    [self.pieChartRight setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChartRight setPieCenter:self.pieChartRight.center];
    [self.pieChartRight setUserInteractionEnabled:YES];
    [self.pieChartRight setLabelShadowColor:[UIColor blackColor]];
    [self.pieChartRight setDelegate:self];
    [self.pieChartRight setShowPercentage:NO];
    [self.pieChartRight setLabelColor:[UIColor whiteColor]];

    self.sliceColors = [NSArray arrayWithObjects:
                        [UIColor redColor],
                        [UIColor blueColor],
                        [UIColor greenColor],
                        [UIColor brownColor],
                        [UIColor yellowColor],
                        [UIColor grayColor],
                        [UIColor lightGrayColor],nil];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToHome:)];
    
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    
    //[self.pieChartRight addGestureRecognizer:swipe];
    [self.view addGestureRecognizer:swipe];
    
    [self.view addSubview:self.pieChartRight];
    [self.view addSubview:self.selectedSliceLabel];
    
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
    Tipo *tipo =  (Tipo*)[[DataManager sharedClass]managedObjectFromFetch:self.fetchObject cell:index];

    return [self.sliceColors objectAtIndex:([tipo.tipoid intValue]-1)];
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

    for (CALayer *sub in self.pieChartRight.layer.sublayers) {
        CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotate.fromValue = [NSNumber numberWithFloat:0];
        rotate.toValue = [NSNumber numberWithFloat:2*M_PI];
        rotate.speed = 2;
        rotate.duration = 3.0;
        rotate.delegate = self;
        rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [sub addAnimation:rotate forKey:@"transform.rotation"];
    }
}

//qnd si ferma l'animazione
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
            GNWheelViewController *wheel = [self.storyboard instantiateViewControllerWithIdentifier:@"Wheel"];
            wheel.title = self.selectedSliceLabel.text;
            wheel.cottura = self.title;
    
            CATransition* transition = [CATransition animation];
            transition.duration = 0.6;
            transition.type = kCATransitionFade;
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:wheel animated:NO];
}

-(NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index{
    
    Tipo *tipo = (Tipo*)[[DataManager sharedClass]managedObjectFromFetch:self.fetchObject cell:index];
    
    return tipo.nametype;
}

-(void)swipeToHome:(UISwipeGestureRecognizer *)sender{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

@end
