//
//  LoginViewController.m
//  VKTool
//
//  Created by Admin on 5/10/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    

    loginWebView.delegate = self;
    [loginWebView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://oauth.vk.com/authorize?client_id=3556651&scope=wall,offline&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token"]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//---------Header implementation----------------------

@synthesize loginWebView;
@synthesize delegate;

-(void) closeWebView
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    
    //создадим хеш-таблицу для хранения данных
    NSMutableDictionary* user = [[NSMutableDictionary alloc] init];
    //смотрим на адрес открытой станицы
    NSString *currentURL = webView.request.URL.absoluteString;
    NSRange textRange =[[currentURL lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
    //смотрим, содержится ли в адресе информация о токене
    if(textRange.location != NSNotFound){
        //Ура, содержится, вытягиваем ее
        NSArray* data = [currentURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [user setObject:[data objectAtIndex:1] forKey:@"access_token"];
        [user setObject:[data objectAtIndex:3] forKey:@"expires_in"];
        [user setObject:[data objectAtIndex:5] forKey:@"user_id"];
        
        [self.delegate userDidLogined:user];
        [self closeWebView];
        //передаем всю информацию специально обученному классу
        //[[VkontakteDelegate sharedInstance] loginWithParams:user];
    }
    else {
        //Ну иначе сообщаем об ошибке...
        textRange =[[currentURL lowercaseString] rangeOfString:[@"access_denied" lowercaseString]];
        if (textRange.location != NSNotFound) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ooops! something gonna wrong..." message:@"Check your internet connection and try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            [self closeWebView];
        }
    }
}



@end
