//
//  LoginViewController.h
//  VKTool
//
//  Created by Admin on 5/10/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginProtocole.h"

@interface LoginViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView* loginWebView;
}

@property (nonatomic, retain) IBOutlet UIWebView* loginWebView;

@property (nonatomic, retain) id<UIWebViewDelegate, UILoginViewDelegate> delegate;

-(void) webViewDidFinishLoad:(UIWebView *)webView;
-(void) userDidLogined:(NSMutableDictionary*)params;

//
//-(void)showLoginForm;
//-(IBAction)closeButton:(id)sender;
//-(void) closeWebView;

@end
