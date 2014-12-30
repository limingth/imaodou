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
    
#if 1
    // Add a web view
	CGRect frame = CGRectInset(self.view.bounds, 2, 2);
	UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
	webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	webView.scalesPageToFit = TRUE;
	[self.view addSubview:webView];
	//[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://maodou.io"]]];
#endif

    UIBarButtonItem *joinchat = [[UIBarButtonItem alloc] initWithTitle:@"Join-Chat" style:UIBarButtonItemStyleBordered target:self action:@selector(joinChat:)];
    UIBarButtonItem *addfriend = [[UIBarButtonItem alloc] initWithTitle:@"Add-a-Friend" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriend:)];
    UIBarButtonItem *signup = [[UIBarButtonItem alloc] initWithTitle:@"Sign-Up" style:UIBarButtonItemStyleDone target:self action:@selector(signup:)];
    

    //self.navigationItem.leftItemsSupplementBackButton = YES;
    
    //Add "Add a Friend" button on left navigator bar
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:joinchat, addfriend, nil];
   
    //Add "Join Chat" button on right navigator bar
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:signup,nil];
    
    // Fill in the App Client ID and Client Secret Key received from the app registration step from Moxtra
    // limingth@gmail.com  APPID at moxtra.com  a NEW ID for iOS learning Group
//    NSString *APP_CLIENT_ID = @"qlE_xR7Ruug";
//    NSString *APP_CLIENT_SECRET = @"kY3skOi3CVM";
  
    NSString *APP_CLIENT_ID = @"ngjsUpq0J8Q";
    NSString *APP_CLIENT_SECRET = @"uuRB46lY-wk";
    
    // Set up Moxtra SDK
    [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];

    // Initialize user using unique user identity
    MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
    useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
    useridentity.userIdentity = @"limingth";
    
#if 1
    [[Moxtra sharedClient] initializeUserAccount: useridentity
                                           orgID: nil
                                       firstName: @"Ming"
                                        lastName: @"Li"
                                          avatar: nil
                     devicePushNotificationToken: nil
                                         success: ^{
                                             NSLog(@"Setup user Ming Li account successfully\n");
                                         } failure: ^(NSError *error) {
                                             NSLog(@"Setup user Ming Li account failed, %@\n", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                         }];
    return;
}

NSString *iOS_Group_ID = @"BLJlyqK34CHEFuQRZo2kJxE";
NSString *firstName;


- (void)addFriend:(id)sender
{
    NSLog(@"addFriend isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Why not Add a Friend?" message:@"Please enter your friend name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    alert2.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert2 textFieldAtIndex:0];
    alertTextField.placeholder = @"Enter your friend's first name";
    [alert2 addButtonWithTitle:@"OK"];
    [alert2 show];
    
    return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        NSLog(@"input: %@", textfield.text);
        
        firstName = textfield.text;
        NSLog(@"Get your firstname: [%@]", firstName);
        
        NSLog(@"user name input: %@", firstName);

        // Initialize user using unique user identity
        MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
        useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
        useridentity.userIdentity = firstName;
        
        NSArray *array = [NSArray arrayWithObjects: firstName, nil];
        [[Moxtra sharedClient] inviteMembersWithUniqueIDs: array
                                                 binderID: iOS_Group_ID
                                                  success: ^{
                                                      NSLog(@"inviteMembersWithUniqueIDs %@ successfully! \n", firstName);
                                                  } failure: ^(NSError *error) {
                                                      NSLog(@"inviteMembersWithUniqueIDs %@ failed, %@ \n", firstName, [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                                  }];
        
    }
    
    if (buttonIndex == 10) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        NSLog(@"input: %@", textfield.text);
        
        firstName = textfield.text;
        NSLog(@"Get your firstname: [%@]", firstName);
        
        NSLog(@"user name input: %@", firstName);
        
        
        NSString *APP_CLIENT_ID = @"ngjsUpq0J8Q";
        NSString *APP_CLIENT_SECRET = @"uuRB46lY-wk";
        
        // Set up Moxtra SDK
        [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];

        // Initialize user using unique user identity
        MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
        useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
        useridentity.userIdentity = firstName;
        
        NSLog(@"1 isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

        // unlinkAccount
        [[Moxtra sharedClient]
         unlinkAccount: ^(BOOL success) {
         }];
        
        NSLog(@"2 isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

        [[Moxtra sharedClient] initializeUserAccount: useridentity
                                               orgID: nil
                                           firstName: firstName
                                            lastName: firstName
                                              avatar: nil
                         devicePushNotificationToken: nil
                                             success: ^{
                                                 NSLog(@"Setup user account %@ successfully! \n", firstName);
                                             } failure: ^(NSError *error) {
                                                 NSLog(@"Setup user account %@ failed, %@ \n", firstName, [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                             }];
        
        NSLog(@"3 isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

        // unlinkAccount
        [[Moxtra sharedClient]
         unlinkAccount: ^(BOOL success) {
         }];
        
        NSLog(@"4 isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);
        
        // Initialize user using unique user identity
        useridentity = [[MXUserIdentity alloc] init];
        useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
        useridentity.userIdentity = @"limingth";
        
        [[Moxtra sharedClient] initializeUserAccount: useridentity
                                               orgID: nil
                                           firstName: @"Ming"
                                            lastName: @"Li"
                                              avatar: nil
                         devicePushNotificationToken: nil
                                             success: ^{
                                                 NSLog(@"Setup user account successfully\n");
                                             } failure: ^(NSError *error) {
                                                 NSLog(@"Setup user account failed, %@\n", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                             }];

        NSLog(@"5 isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

        NSArray *array = [NSArray arrayWithObjects: firstName, nil];
        [[Moxtra sharedClient] inviteMembersWithUniqueIDs: array
                                                 binderID: iOS_Group_ID
                                                  success: ^{
                                                      NSLog(@"inviteMembersWithUniqueIDs successfully! \n");
                                                  } failure: ^(NSError *error) {
                                                      NSLog(@"inviteMembersWithUniqueIDs %@ failed, %@ \n", firstName, [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
                                                  }];
        
        NSLog(@"6 isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);
        
#if 0
        // unlinkAccount
        [[Moxtra sharedClient]
         unlinkAccount: ^(BOOL success) {
         }];
#endif
        
        return;
    }
    else {
        NSLog(@"user pressed Cancel");
    }
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
    
#endif
    
    NSLog(@"AFTER isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

}


- (void)joinChat:(id)sender
{
    NSLog(@"AFTER isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input your Sign In name and Join Chat" message:@"Please enter your name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.placeholder = @"Enter your name";
    [alert addButtonWithTitle:@"OK"];
    [alert show];

#if 1
    [[Moxtra sharedClient] openChat: iOS_Group_ID
                      withPopupRect: CGRectMake(290, 538, 50, 50)
                            success: ^{
                                NSLog(@"openChat successfully \n");
                            } failure: ^(NSError *error) {
                                NSLog(@"openChat failed, %@ \n", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);                            }];
#endif
    
    NSLog(@"AFTER isUserLoggedIn %d , getUserName %@ %@ \n", [[Moxtra sharedClient] isUserLoggedIn], [[Moxtra sharedClient] getUserFirstName], [[Moxtra sharedClient] getUserLastName]);

#if 0
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
