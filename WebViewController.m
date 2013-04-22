//
//  WebViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/21/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize theURL = _theURL;
@synthesize toolbar = _toolbar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:_theURL];
    [self.webView loadRequest:requestObject];
    NSLog(@"Loading: %@", _theURL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openInSafari:(UIBarButtonItem *)sender {
    UIActionSheet *openSafari = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open Safari", nil];
    [openSafari showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {    
    switch (buttonIndex) {
            // Take Photo
        case 0:
        {
            [[UIApplication sharedApplication] openURL:_theURL];
        }
            break;
        default:
            break;
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.webView.delegate = nil;
    [self.webView stopLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [errorView show];
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
