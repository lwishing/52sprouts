//
//  LoginViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/10/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *imageData;
@property (weak, nonatomic) IBOutlet UILabel *sprouts;
@property (weak, nonatomic) IBOutlet UILabel *blurb;

@end
