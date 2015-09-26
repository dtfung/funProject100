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

- (IBAction)spinButton:(id)sender {
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UIDynamicItemBehavior *rotation = [[UIDynamicItemBehavior alloc]initWithItems:@[self.appPartnerIcon]];
    rotation.allowsRotation = YES;
    [rotation addAngularVelocity:1 forItem:self.appPartnerIcon];
    [animator addBehavior:rotation];
    
    UIPushBehavior *pusher = [[UIPushBehavior alloc]initWithItems:@[self.appPartnerIcon] mode:UIPushBehaviorModeInstantaneous];
    pusher.angle = 360;
    pusher.magnitude = 1;
    pusher.pushDirection = CGVectorMake(1.0, 1.0);
    pusher.active = YES;
    [animator addBehavior:pusher];
    
    
}
@end
