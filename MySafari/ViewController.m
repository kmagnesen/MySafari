//
//  ViewController.m
//  MySafari
//
//  Created by Kyle Magnesen on 1/7/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIButton *myBackButton;
@property (strong, nonatomic) IBOutlet UIButton *myForwardButton;

@end

@implementation ViewController

-(void)loadURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: urlRequest];
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

-(void)loadHome {
    [self loadURL:@"http://google.com"];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];

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
    [self loadURL: textField.text];
    return YES;
}




@end
