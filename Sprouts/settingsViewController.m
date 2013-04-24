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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 6, 300, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(53/255.0) green:(135/255.0) blue:(93/255.0) alpha:1.0];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.text = sectionTitle;
    [label setFont:[UIFont fontWithName:@"MuseoSans-500" size:20.0]];
    
    // Create header view and add label as a subview
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    [view addSubview:label];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *sectionFooter = [self tableView:tableView titleForFooterInSection:section];
    if (sectionFooter == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 6, 300, 30);
    label.backgroundColor = [UIColor clearColor];
    label.text = sectionFooter;
    [label setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.textLabel setFont:[UIFont fontWithName:@"MuseoSans-500" size:17.0]];
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
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com/privacy"];
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)loadTOS:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com/terms"];
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
