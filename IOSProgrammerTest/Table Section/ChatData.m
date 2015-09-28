//
//  ChatData.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/19/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatData.h"

@implementation ChatData
- (void)loadWithDictionary:(NSDictionary *)dict
{
    self.user_id = [[dict objectForKey:@"user_id"] intValue];
    self.username = [dict objectForKey:@"username"];
    self.avatar_url = [dict objectForKey:@"avatar_url"];
    self.message = [dict objectForKey:@"message"];

    
    //Request image data from the URL:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.avatar_url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (imgData)
            {
                //Load the data into an UIImage:
                UIImage *image = [UIImage imageWithData:imgData];
                
                //Check if your image loaded successfully:
                if (image)
                {
                    
                   _imageName = image;
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"pictureNotification" object:nil];
                
                }
                else
                {
                    //Failed to load the data into an UIImage:
                    _imageName = [UIImage imageNamed:@"no-data-image.png"];
                }
            }
            else
            {
                //Failed to get the image data:
                _imageName = [UIImage imageNamed:@"no-data-image.png"];
            }
        });
    });
}



@end
