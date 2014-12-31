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

NSString *status = @"SignUp";

NSString *iOS_Group_ID = @"BB100CKVqIv7ZczcqSpo669";
NSString *firstName, *lastName, *userName;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
#if 1
    // Add a web view
	CGRect frame = CGRectInset(self.view.bounds, 2, 2);
	UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
	webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	webView.scalesPageToFit = TRUE;
	[self.view addSubview:webView];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://maodou.io"]]];
#endif

    UIBarButtonItem *joinchat = [[UIBarButtonItem alloc] initWithTitle:@"Join Chat" style:UIBarButtonItemStyleBordered target:self action:@selector(joinChat:)];
    UIBarButtonItem *addfriend = [[UIBarButtonItem alloc] initWithTitle:@"Add a Friend" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriend:)];
    //IBarButtonItem *signup = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up" style:UIBarButtonItemStyleDone target:self action:@selector(signup:)];
    

    //self.navigationItem.leftItemsSupplementBackButton = YES;
    
    //Add "Add a Friend" button on left navigator bar
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:addfriend, nil];
   
    //Add "Join Chat" button on right navigator bar
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:joinchat,nil];
    
    // Fill in the App Client ID and Client Secret Key received from the app registration step from Moxtra
    NSString *APP_CLIENT_ID = @"lB5Llgzp0wQ";
    NSString *APP_CLIENT_SECRET = @"irOWnR4ELPE";
    
    // Set up Moxtra SDK
    [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];
    
    NSLog(@"ViewDidLoad isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);
    
    if ([[Moxtra sharedClient] isUserLoggedIn] == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sign Up your name here"
                                                         message:@""
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"OK", nil];
        
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        
        UITextField * alertTextField1 = [alert textFieldAtIndex:0];
        alertTextField1.keyboardType = UIKeyboardTypeDefault;
        alertTextField1.placeholder = @"Enter first name: Bill";
        [[alert textFieldAtIndex:0] setSecureTextEntry:NO];
        
        UITextField * alertTextField2 = [alert textFieldAtIndex:1];
        alertTextField2.keyboardType = UIKeyboardTypeDefault;
        alertTextField2.placeholder = @"Enter last name: Gates";
        [[alert textFieldAtIndex:1] setSecureTextEntry:NO];

        [alert show];
    }
    else
    {
        firstName = [[Moxtra sharedClient] getUserFirstName];
        lastName = [[Moxtra sharedClient] getUserLastName];
        userName = [firstName stringByAppendingString: @" "];
        userName = [userName stringByAppendingString: lastName];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Welcome Back, %@ %@", firstName, lastName] message:@"You are the most valuable friend \nthat we ever have!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
    return;
}

- (void)addFriend:(id)sender
{
    NSLog(@"addFriend isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

    status = @"AddFriend";
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add your friend's name here"
                                                     message:@""
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    UITextField * alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.keyboardType = UIKeyboardTypeDefault;
    alertTextField1.placeholder = @"Enter first name: Bill";
    [[alert textFieldAtIndex:0] setSecureTextEntry:NO];
    
    UITextField * alertTextField2 = [alert textFieldAtIndex:1];
    alertTextField2.keyboardType = UIKeyboardTypeDefault;
    alertTextField2.placeholder = @"Enter last name: Gates";
    [[alert textFieldAtIndex:1] setSecureTextEntry:NO];

    [alert show];
    
    return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *alertTextField1 = [alertView textFieldAtIndex:0];
    UITextField *alertTextField2 = [alertView textFieldAtIndex:1];
    
    firstName = alertTextField1.text;
    lastName = alertTextField2.text;
    userName = [firstName stringByAppendingString: lastName];
    
    NSLog(@"Get a name: [%@ %@]", firstName, lastName);
    
    if (buttonIndex == 1 && [status isEqual: @"SignUp"]) {
        NSLog(@"sign up your name is [%@ %@] %@", firstName, lastName, userName);
        // Initialize user using unique user identity
        MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
        useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
        useridentity.userIdentity = userName;
        
        [[Moxtra sharedClient] initializeUserAccount: useridentity
                                               orgID: nil
                                           firstName: firstName
                                            lastName: lastName
                                              avatar: nil
                         devicePushNotificationToken: nil
                                             success: ^{
                                                 NSLog(@"Setup user account %@ successfully! \n", firstName);
                                                 
                                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!  :)" message:[NSString stringWithFormat:@"Your account \"%@ %@\" is created sucessfully.", firstName, lastName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                 
                                                 [alert show];
                                                 
                                             } failure: ^(NSError *error) {
                                                 NSLog(@"Setup user account %@ failed, %@ \n", firstName, [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                                 
                                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!  :(" message:@"This account already exist." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                 
                                                 [alert show];
                                             }];
        return;
    }
    
    if (buttonIndex == 1 && [status isEqual: @"AddFriend"]) {
        NSLog(@"add your friend name is [%@ %@] %@", firstName, lastName, userName);
        
        NSArray *array = [NSArray arrayWithObjects: userName, nil];
        [[Moxtra sharedClient] inviteMembersWithUniqueIDs: array
                                                 binderID: iOS_Group_ID
                                                  success: ^{
                                                      NSLog(@"inviteMembersWithUniqueIDs %@ successfully! \n", firstName);
                                                      
                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!  :)" message:[NSString stringWithFormat:@"Your friend account \"%@ %@\" is added into this chat group sucessfully.", firstName, lastName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                      
                                                      [alert show];
                                                  } failure: ^(NSError *error) {
                                                      NSLog(@"inviteMembersWithUniqueIDs %@ failed, %@ \n", firstName, [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                                      
                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!  :(" message:[NSString stringWithFormat:@"Make sure your friend account \"%@ %@\" is already signed up by himself.", firstName, lastName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                      
                                                      [alert show];
                                                  }];
        return;
    }
    
#if 0
        // unlinkAccount
        [[Moxtra sharedClient]
         unlinkAccount: ^(BOOL success) {
         }];
#endif
    
    NSLog(@"user pressed Cancel");
}

- (void)signup:(id)sender
{
    NSLog(@"Before isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Why not Add a Friend?" message:@"Please enter your friend name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.placeholder = @"Enter your first name";
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    
    return;
}


- (void)joinChat:(id)sender
{
    NSLog(@"before JoinChat isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

#if 1
    if ([[Moxtra sharedClient] isUserLoggedIn] == 1)
    {
        [[Moxtra sharedClient] openChat: iOS_Group_ID
                          withPopupRect: CGRectMake(290, 538, 50, 50)
                                success: ^{
                                    NSLog(@"openChat successfully \n");
                                } failure: ^(NSError *error) {
                                    NSLog(@"openChat failed, %@ \n", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                    
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are not in this chat" message:@"Ask group member to Add you in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    
                                    [alert show];
                                }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are not logged in" message:@"Please Sign Up your name first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
#else
    
    [[Moxtra sharedClient] createChat:CGRectMake(290, 538, 50, 50)
                   inviteMembersEmail:nil
                inviteMembersUniqueID:nil
                              success:^(NSString *conversationID) {
                                  NSLog(@"start conversation success, id = %@ \n", conversationID);
                                  //self.conversationID1 = conversationID;
                                  
                              } failure:^(NSError *error) {
                                  NSLog(@"start conversation failed \n");
                              }];
#endif
 /*   [[Moxtra sharedClient] inviteMembersWithUniqueIDs: array
                                          binderID: binderID
                                           success: ^{
                                               NSLog(@"inviteMembersWithUniqueIDs successfully");
                                           } failure: ^(NSError *error) {
                                               NSLog(@"inviteMembersWithUniqueIDs failed");
                                           }];



   [[Moxtra sharedClient] inviteMembersWithEmails: array
                                             binderID: conversationID
                                              success: ^{
                                                  NSLog(@"inviteMembersWithUniqueIDs successfully");
                                              } failure: ^(NSError *error) {
                                                  NSLog(@"inviteMembersWithUniqueIDs failed");
                                              }];
*/

    //    [[Moxtra sharedClient] setDelegate:self];
    
/*
    [[Moxtra sharedClient] createChat:CGRectMake(290, 538, 50, 50)
                   inviteMembersEmail:nil
                inviteMembersUniqueID:nil
                              success:^(NSString *conversationID) {
        NSLog(@"start conversation success, id = %@", conversationID);
        //self.conversationID1 = conversationID;
 
   } failure:^(NSError *error) {
        NSLog(@"start conversation failed");
    }];
*/
//    [[Moxtra sharedClient] setDelegate:self];
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
