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
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"Join Meet" style:UIBarButtonItemStyleBordered target:self action:@selector(joinMeet:)],nil];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"Start Meet" style:UIBarButtonItemStyleBordered target:self action:@selector(startMeet:)],nil];
    
    // Fill in the App Client ID and Client Secret Key received from the app registration step from Moxtra
    NSString *APP_CLIENT_ID = @"uGvPYrH651o";
    NSString *APP_CLIENT_SECRET = @"pIWm8f-u91g";
    
    // Set up Moxtra SDK
    [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];
    
    // Initialize user using unique user identity
    MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
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

- (void)startMeet:(id)sender
{
    [[Moxtra sharedClient] setMeetStyleWithColor:[UIColor lightGrayColor]];
    // Start meet
    [[Moxtra sharedClient]
     startMeet: @"Moxtra Meet"
     withDelegate: nil
     inviteAttendeesBlock: nil
     success: ^(NSString *meetID) {
         NSLog(@"Start meet successfully with MeetID [%@]", meetID);
     } failure: ^(NSError *error) {
         NSLog(@"Start meet failed, %@", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
     }];
    return;
}

- (void)joinMeet:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Please enter the meet id:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Enter meet id";
    [alert addButtonWithTitle:@"Continue"];
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[Moxtra sharedClient] setMeetStyleWithColor:[UIColor lightGrayColor]];
        
        UITextField *textfield = [alertView textFieldAtIndex:0];
        NSLog(@"meet id input: %@", textfield.text);
        
        NSString *meetId = textfield.text;
        
        //Join Moxtra Meet
        [[Moxtra sharedClient]
         joinMeet: meetId
         withUserName: @"maodou"
         withDelegate: nil
         inviteAttendeesBlock: nil
         success: ^(NSString *meetID) {
             NSLog(@"Join meet success with MeetID [%@]", meetID);
         } failure: ^(NSError *error) {
             NSLog(@"Join meet failed, %@", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
         }];
        return;
    }
    else {
        NSLog(@"user pressed Cancel");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
