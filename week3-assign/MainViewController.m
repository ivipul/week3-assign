//
//  MainViewController.m
//  week3-assign
//
//  Created by Vipul Thakur on 7/8/14.
//  Copyright (c) 2014 ivipul. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIImageView *headline;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)onPanGestureParent:(UIPanGestureRecognizer *)panGestureRecognizer;
- (void)callHighlight;
- (void)changeHighlight;

@end

@implementation MainViewController
    CGFloat startLocation, endLocation, frameStartLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake(1444, 253.5);
    [self callHighlight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanGestureParent:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
   
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        startLocation = location.y;
        frameStartLocation = self.parentView.center.y;
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        if ((frameStartLocation == 284 && (startLocation - location.y) < 0) || (frameStartLocation == 807 && (startLocation - location.y) >= 0))
            self.parentView.center = CGPointMake(self.parentView.center.x, frameStartLocation - (startLocation - location.y));
        else if ((frameStartLocation == 284 && (startLocation - location.y) >= 0) || (frameStartLocation == 807 && (startLocation - location.y) < 0))
            self.parentView.center = CGPointMake(self.parentView.center.x, frameStartLocation - (startLocation - location.y)/10);
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        endLocation = location.y;
        BOOL topHalf = true;
        BOOL slowVelocity = true;
        NSLog(@"%f", (startLocation-endLocation) );
        if (frameStartLocation == 284 && (startLocation-endLocation) < -262){
            topHalf = false;
        }
        if (frameStartLocation == 284 && velocity.y >= 200){
            slowVelocity = false;
        }
        if (frameStartLocation == 284 && topHalf && slowVelocity){
            [UIView animateWithDuration:0.3
                             animations:^{
                                self.parentView.center = CGPointMake(self.parentView.center.x, 284);
                             }
                             completion:nil];
        }
        else if (frameStartLocation == 284 && !(topHalf && slowVelocity)){
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.parentView.center = CGPointMake(self.parentView.center.x, 807);
                             }
                             completion:nil];
        }
        
        if (frameStartLocation == 807 && (startLocation-endLocation) >= 50){
            topHalf = false;
        }
        if (frameStartLocation == 807 && velocity.y >= 200){
            slowVelocity = false;
        }
        if (frameStartLocation == 807 && topHalf){
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.parentView.center = CGPointMake(self.parentView.center.x, 807);
                             }
                             completion:nil];
        }
        else if (frameStartLocation == 807 && !(topHalf && slowVelocity)){
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.parentView.center = CGPointMake(self.parentView.center.x, 284);
                             }
                             completion:nil];
        }
        
        
        NSLog(@"Panning location: %f", location.y);
        NSLog(@"Panning velocity: %f", velocity.y);
    }
}


- (void)callHighlight{
    [self performSelector:@selector(changeHighlight) withObject:nil afterDelay:8];
}

- (void)changeHighlight{
    NSLog(@"changing");
    [UIView transitionWithView:self.image1
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image1.image = [UIImage imageNamed:@"2"];;
                    } completion:NULL];
    [self callHighlight];
}

@end
