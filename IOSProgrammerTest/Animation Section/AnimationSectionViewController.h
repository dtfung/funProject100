//
//  AnimationSectionViewController.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationSectionViewController : UIViewController <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *appPartnerIcon;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIPushBehavior *pusher;
@property (strong, nonatomic) UIDynamicItemBehavior *rotation;


@end
