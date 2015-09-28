//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"
@interface LoginSectionViewController ()

@end

@implementation LoginSectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Login";
    
    
    
    
}

- (void)pushToRoot {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

- (IBAction)logIn:(id)sender {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject];
    
    NSURL * url = [NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString * params = [NSString stringWithFormat: @"username=%@&password=%@",self.usernameField.text,self.passwordField.text];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                               NSLog(@"Data = %@",text);
                                                               
                                                           }
                                                           
                                                           
                                                           
                                                           NSTimeInterval startTimer = [NSDate timeIntervalSinceReferenceDate];
                                                           
                                                           // Get on main queue
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               
                                                               // timer (in miliseconds)
                                                               NSTimeInterval elapsedTimer = ([NSDate timeIntervalSinceReferenceDate] - startTimer) * 1000;
                                                               
                                                               // Cenvert JSON into NSDictionary
                                                               NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                                               // Create in UIAlert
                                                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dictionary objectForKey:@"code"]
                                                                                                                              message: [NSString stringWithFormat:@"%@\n\nAPI call took %f milliseconds",[dictionary valueForKey:@"message"], elapsedTimer]
                                                                                                                       preferredStyle:UIAlertControllerStyleAlert];
                                                               // Create UIAlertAction
                                                               UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                                   // If login is successful, bring back to main screen
                                                                   if ([[dictionary valueForKey:@"code"] isEqualToString: @"Success"]) {
                                                                       [self pushToRoot];                                                          }
                                                               }];
                                                               [alert addAction:dismiss];
                                                               [self presentViewController:alert animated:YES completion:nil];
                                                               
                                                           });
                                                           
                                                           
                                                           
                                                       }];
    [dataTask resume];
    
}







@end
