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
}

- (void)loadWithData:(ChatData *)chatData
{
//    NSData *data = [NSData dataWithContentsOfURL : chatData.avatar_url];
//    UIImage *image = [UIImage imageWithData: data];
    
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
   // self.userImage.image = image;
}
@end
