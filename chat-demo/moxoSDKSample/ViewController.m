//
//  ViewController.m
//  moxoSDKSample
//
//  Created by Stone Wang on 7/8/14.
//  Copyright (c) 2014 xebew. All rights reserved.
//

#import "ViewController.h"
#import "Moxtra.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add a web view
	CGRect frame = CGRectInset(self.view.bounds, 2, 2);
	UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
	webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	webView.scalesPageToFit = TRUE;
	[self.view addSubview:webView];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
    
    //Add test button on navigator bar
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"Start Chat" style:UIBarButtonItemStyleBordered target:self action:@selector(startChat:)],nil];
    
    // Fill in the App Client ID and Client Secret Key received from the app registration step from Moxtra
    NSString *APP_CLIENT_ID = @"uGvPYrH651o";
    NSString *APP_CLIENT_SECRET = @"pIWm8f-u91g";
    
    // Set up Moxtra SDK
    [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];
    
    // Initialize user using unique user identity
    MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
    //useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
    //useridentity.userIdentity = @"user unique identity";
    useridentity.userIdentityType = kUserIdentityTypeEmail;
    useridentity.userIdentity = @"farcryzry@gmail.com";
    
    [[Moxtra sharedClient]
     initializeUserAccount: useridentity
     firstName: @"John"
     lastName: @"Doe"
     avatar: nil
     devicePushNotificationToken: nil
     success: ^{
         NSLog(@"Setup user account successfully");
     } failure: ^(NSError *error) {
         NSLog(@"Setup user account failed, %@", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
     }];

    
}

- (void)startChat:(id)sender
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"znq@maodou.io",
                      @"gaoyancc@gmail.com",
                      @"farcryzry@gmail.com",
                      @"limingth@maodou.io",nil];
    
    [[Moxtra sharedClient] createChat:CGRectMake(290, 538, 50, 50)
                   inviteMembersEmail:nil
                inviteMembersUniqueID:nil
                              success:^(NSString *conversationID) {
        NSLog(@"start conversation success, id = %@", conversationID);
        //self.conversationID1 = conversationID;
                                  
                                  [[Moxtra sharedClient] inviteMembersWithEmails: array
                                                                        binderID: conversationID
                                                                         success: ^{
                                                                             NSLog(@"inviteMembersWithEmails successfully");
                                                                         } failure: ^(NSError *error) {
                                                                             NSLog(@"inviteMembersWithEmails failed");
                                                                         }];
                                  
                                  
                                  
                                  
   } failure:^(NSError *error) {
        NSLog(@"start conversation failed");
    }];
    
    [[Moxtra sharedClient] setDelegate:self];
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
