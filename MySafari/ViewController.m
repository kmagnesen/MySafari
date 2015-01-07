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

@end

@implementation ViewController


- (IBAction)onStopLoadingButtonPressed:(id)sender {
}

- (IBAction)onForwardButtonPressed:(id)sender {
}

- (IBAction)onBackButtonPressed:(id) sender {

}

- (void) stopLoading {
    
}

- (void) goBack{

}

- (void) goForward{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadURL: textField.text];
    return YES;
}




@end
