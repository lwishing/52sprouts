//
//  settingsViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "settingsViewController.h"
#import "WebViewController.h"

@interface settingsViewController ()

@end

@implementation settingsViewController

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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.tableView setBackgroundView:imageView];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self loadPrivacyPolicy:self];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        [self loadTOS:self];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [self loadWebsite:self];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        [self loadTwitter:self];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        [self logoutPressed:self];
    }
}


- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (IBAction)loadPrivacyPolicy:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"https://parse.com/about/privacy"];
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)loadTOS:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"https://parse.com/about/terms"];
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)loadWebsite:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com"];
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)loadTwitter:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"https://twitter.com/52sprouts"];
    [self presentViewController:webViewController animated:YES completion:nil];
    //[self.navigationController pushViewController:webViewController animated:YES];

}

@end
