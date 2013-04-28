//
//  WebViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/21/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *theURL;
@property (weak, nonatomic) NSString *theTitle;

- (IBAction)openInSafari:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *theToolbar;
@property (weak, nonatomic) IBOutlet UILabel *toolbarLabel;
@property (weak, nonatomic) IBOutlet UIView *toolbarLabelView;

@end
