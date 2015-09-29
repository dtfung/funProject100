//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"

@interface AnimationSectionViewController ()

@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Animation";
    
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

- (IBAction)spinButton:(id)sender
{
    _pusher = [[UIPushBehavior alloc]initWithItems:@[self.appPartnerIcon] mode:UIPushBehaviorModeInstantaneous];
    self.pusher.angle = 360;
    self.pusher.active = YES;
    [self.animator addBehavior:self.pusher];
    
    _rotation = [[UIDynamicItemBehavior alloc]initWithItems:@[self.appPartnerIcon]];
    self.rotation.allowsRotation = YES;
    [self.rotation addAngularVelocity:1 forItem:self.appPartnerIcon];
    [self.animator addBehavior:self.rotation];
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                     sender.view.center.y + translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    [self.animator updateItemUsingCurrentState:self.appPartnerIcon];
}

- (IBAction)Push:(id)sender {
    UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:@[self.appPartnerIcon] mode:UIPushBehaviorModeInstantaneous];
    push.active = YES;
    push.pushDirection = CGVectorMake(0.0, 1.0);
    [self.animator addBehavior:push];
    
    [self.animator updateItemUsingCurrentState:self.appPartnerIcon];
    
    UIDynamicItemBehavior * dynamicBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.appPartnerIcon]];
    dynamicBehavior.elasticity = .8;
    [dynamicBehavior addAngularVelocity:.5 forItem:self.appPartnerIcon];
    [self.animator addBehavior:dynamicBehavior];
    
    //add collisions
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.appPartnerIcon]];
    collision.collisionDelegate = self;
    collision.collisionMode = UICollisionBehaviorModeEverything;
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}


@end
