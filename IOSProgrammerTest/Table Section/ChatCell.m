//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@end

@implementation ChatCell

- (void)awakeFromNib
{
    // Customize shape of image
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.clipsToBounds =YES;
}

- (void)loadWithData:(ChatData *)chatData
{
    // Assign values from JSON file
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    self.userImage.image = chatData.imageName;
    
    //  Receive a notification & then assign value to image view
    [[NSNotificationCenter defaultCenter] addObserverForName:@"pictureNotification" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.userImage.image = chatData.imageName;
    }];
    
    //  Remove observer once it has been notified
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pictureNotification" object:nil];
}

@end
