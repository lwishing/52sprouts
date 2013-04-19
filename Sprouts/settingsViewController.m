//
//  settingsViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "settingsViewController.h"

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
        
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        [PFUser logOut];
        [self performSegueWithIdentifier:@"logout" sender:self];
    }
}


- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

@end
