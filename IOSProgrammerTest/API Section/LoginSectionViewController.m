//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"//Users/Don/Documents/github/funProject100/IOSProgrammerTest/API Section/LoginSectionViewController.xib

@interface LoginSectionViewController ()

@end

@implementation LoginSectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Login";
    
    _dictionary=[[NSDictionary alloc]init];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
        MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
        [self.navigationController pushViewController:mainMenuViewController animated:YES];
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
    
    NSString *usernameText = self.usernameField.text;
   NSString *passwordText = self.passwordField.text;
    NSLog(@"username=%@&password=%@",usernameText,passwordText);
    //NSString * params =  @"username=%p&password=%p",&usernameText,&passwordText;
    NSString * params =  @"username=Superoise&password=qwerty";
    //NSDictionary *params = @{@"username": self.usernameField.text, @"password": self.passwordField.text};
    
    //NSData * json = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
    //urlRequest.HTTPBody = json;

    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                               NSLog(@"Data = %@",text);
                                                               
                                                           }
                                                           
                                                          _dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                options:kNilOptions
                                                                                                                  error:nil];
                                                           
                                                           [self alertView];

                                            
                                                       }];
        [dataTask resume];
    
   }

- (void)alertView {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[_dictionary objectForKey:@"code"]
                                                                   message:[_dictionary objectForKey:@"message"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:NULL];
    
    
}

//- (void)pushToRoot {
//    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
//    [self.navigationController pushViewController:mainMenuViewController animated:YES];
//}




@end
