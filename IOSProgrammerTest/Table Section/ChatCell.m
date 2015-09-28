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
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.clipsToBounds =YES;
    
    // NSNotification: Make self an observer
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(loadWithData:)
    //                                                 name:@"pictureNotification"
    //                                               object:nil];
}

- (void)loadWithData:(ChatData *)chatData

{
    
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    self.userImage.image = chatData.imageName;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"pictureNotification" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.userImage.image = chatData.imageName;
    }];
    
    //Remove observer once it has been notified 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pictureNotification" object:nil];
    
}

@end
