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
@synthesize theTitle = _theTitle;
@synthesize theToolbar = _theToolbar;
@synthesize toolbarLabel = _toolbarLabel;
@synthesize toolbarLabelView = _toolbarLabelView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.navigationItem.title = _theTitle;
    _toolbarLabel.text = _theTitle;
    [_toolbarLabel setTextColor:[UIColor colorWithRed:(43/255.0) green:(36/255.0) blue:(19/255.0) alpha:1.0]];
    [_toolbarLabel setShadowColor:[UIColor colorWithRed:(190/255.0) green:(155/255.0) blue:(101/255.0) alpha:1.0]];
    [_toolbarLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    [_toolbarLabel setFont:[UIFont fontWithName:@"MuseoSans-700" size:20.0f]];
    [_toolbarLabel setBackgroundColor:[UIColor clearColor]];
    [_toolbarLabelView setBackgroundColor:[UIColor clearColor]];
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:_theURL];
    [self.webView loadRequest:requestObject];
    NSLog(@"Loading: %@", _theURL);
    
    [_theToolbar setBackgroundImage:[UIImage imageNamed:@"toolbar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"action.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(openInSafari:)];
    
//    self.navigationItem.rightBarButtonItem = barButton;
    
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

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
