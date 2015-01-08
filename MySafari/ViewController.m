//
//  ViewController.m
//  MySafari
//
//  Created by Kyle Magnesen on 1/7/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewAccessibilityDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIButton *myBackButton;
@property (strong, nonatomic) IBOutlet UIButton *myForwardButton;
@property (strong, nonatomic) IBOutlet UIButton *onPlusButtonPressed;

@end

@implementation ViewController


-(void)loadURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: urlRequest];
}
- (IBAction)onPlusButtonPressed:(id)sender {

    UIAlertView *comingSoonAlert = [[UIAlertView alloc] initWithTitle:@"Coming Soon!" message:@"Additional browser windows." delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];

    [comingSoonAlert show];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];

}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHome];
}

//-(void)updateButtons
//{
//    self.myBackButton.enabled = self.webView.canGoBack;
//    self.myForwardButton.enabled = self.webView.canGoForward;
//}


-(void)loadHome {
    [self loadURL:@"http://google.com"];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];

    NSString *displayURL = webView.request.URL.absoluteString;
    self.urlTextField.text = displayURL;

    self.navBar.topItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    if (self.webView.canGoForward == YES) {
        [self.myForwardButton setEnabled:YES];
    } else {
        [self.myForwardButton setEnabled:NO];
    }

    if (self.webView.canGoBack == YES) {
        [self.myBackButton setEnabled:YES];
    } else {
        [self.myBackButton setEnabled:NO];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Stupid Ass Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Go Home", nil];
    [alert show];
    [self.spinner stopAnimating];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self loadHome];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSURL *userURL = [NSURL URLWithString:self.urlTextField.text];
    NSString *userURLString = self.urlTextField.text;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:userURL];

    NSString *myHTTP = @"http://";

    if ([userURLString hasPrefix:@"http://"] || [userURLString hasPrefix:@"http://"]) {
        [self.webView loadRequest:urlRequest];
    } else {
        NSURL *myHTTPResult = [NSURL URLWithString:[myHTTP stringByAppendingString:userURLString]];
        NSURLRequest *urlRequest1 = [NSURLRequest requestWithURL:myHTTPResult];

        [self.webView loadRequest:urlRequest1];

    }
    return YES;
}




@end
