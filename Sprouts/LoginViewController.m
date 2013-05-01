//
//  loginViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/10/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "LoginViewController.h"
#import "SproutsTabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

//@synthesize sprouts, blurb, loginButton;

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
    
    // Create the scrollview with specific frame
    ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 345)];
    
    
    // Step 1
    UIView *stepOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 345)];
    
    UILabel *sprouts = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    sprouts.text = @"52 Sprouts";
    sprouts.textAlignment = NSTextAlignmentCenter;
    [sprouts setFont:[UIFont fontWithName:@"MuseoSans-500" size:42.0]];
    sprouts.backgroundColor = [UIColor clearColor];
    sprouts.textColor = [UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0];
    sprouts.shadowColor = [UIColor whiteColor];
    sprouts.shadowOffset = CGSizeMake(0, 1);
    [sprouts setUserInteractionEnabled:NO];
    [stepOne addSubview:sprouts];
    
    UIImageView *imageViewOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"step1.png"]];
    imageViewOne.frame = CGRectMake(self.view.frame.size.width/2 - imageViewOne.frame.size.width/2, 80, imageViewOne.frame.size.width, imageViewOne.frame.size.height);
    [stepOne addSubview:imageViewOne];
    
    UILabel *headerViewOne = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 95, 250, 190, 60)];
    headerViewOne.textAlignment = NSTextAlignmentCenter;
    headerViewOne.numberOfLines = 0; //allows as many lines as needed for UILabel
    headerViewOne.text = @"Mastering the kitchen, one vegetable at a time.";
    [headerViewOne setFont:[UIFont fontWithName:@"MuseoSans-500" size:16.0]];
    headerViewOne.textColor = [UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0];
    headerViewOne.shadowColor = [UIColor whiteColor];
    headerViewOne.shadowOffset = CGSizeMake(0, 1);
    headerViewOne.backgroundColor = [UIColor clearColor];
    [headerViewOne setUserInteractionEnabled:NO];
    [stepOne addSubview:headerViewOne];
    
    /*UITextView *subHeaderViewOne = [[UITextView alloc] initWithFrame:CGRectMake(10, 285, (self.view.frame.size.width - 20), 50)];
    subHeaderViewOne.text = @"  ";
    [subHeaderViewOne setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    subHeaderViewOne.backgroundColor = [UIColor clearColor];
    [subHeaderViewOne setUserInteractionEnabled:NO];
    [stepOne addSubview:subHeaderViewOne];*/
    
    
    // Step 2
    UIView *stepTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 345)];
    
    UIImageView *imageViewTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"step2.png"]];
    imageViewTwo.frame = CGRectMake(self.view.frame.size.width/2 - imageViewTwo.frame.size.width/2, 0, imageViewTwo.frame.size.width, imageViewTwo.frame.size.height);
    [stepTwo addSubview:imageViewTwo];
    
    UILabel *headerViewTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, (self.view.frame.size.width - 20), 60)];
    headerViewTwo.textAlignment = NSTextAlignmentCenter;
    headerViewTwo.numberOfLines = 0;
    headerViewTwo.text = @"Each week, we'll pick a vegetable that's in season and give you information to get you started.";
    [headerViewTwo setFont:[UIFont fontWithName:@"MuseoSans-500" size:16.0]];
    headerViewTwo.textColor = [UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0];
    headerViewTwo.shadowColor = [UIColor whiteColor];
    headerViewTwo.shadowOffset = CGSizeMake(0, 1);
    headerViewTwo.backgroundColor = [UIColor clearColor];
    [headerViewTwo setUserInteractionEnabled:NO];
    [stepTwo addSubview:headerViewTwo];
    
    /*UITextView *subHeaderViewTwo = [[UITextView alloc] initWithFrame:CGRectMake(10, 285, (self.view.frame.size.width - 20), 50)];
    subHeaderViewTwo.text = @"Show us your expertise and learn from the 52 Sprouts community.";
    [subHeaderViewTwo setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    subHeaderViewTwo.backgroundColor = [UIColor clearColor];
    [subHeaderViewTwo setUserInteractionEnabled:NO];
    [stepTwo addSubview:subHeaderViewTwo];*/
    
    
    // Step 3
    UIView *stepThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 345)];
    
    UIImageView *imageViewThree = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"step3.png"]];
    imageViewThree.frame = CGRectMake(self.view.frame.size.width/2 - imageViewThree.frame.size.width/2, 0, imageViewThree.frame.size.width, imageViewThree.frame.size.height);
    [stepThree addSubview:imageViewThree];
    
    UILabel *headerViewThree = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, (self.view.frame.size.width - 20), 60)];
    headerViewThree.textAlignment = NSTextAlignmentCenter;
    headerViewThree.numberOfLines = 0;
    headerViewThree.text = @"Sprout your delicious creations, recipes, and tips to share and learn from the larger 52 Sprouts community.";
    [headerViewThree setFont:[UIFont fontWithName:@"MuseoSans-500" size:16.0]];
    headerViewThree.textColor = [UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0];
    headerViewThree.shadowColor = [UIColor whiteColor];
    headerViewThree.shadowOffset = CGSizeMake(0, 1);
    headerViewThree.backgroundColor = [UIColor clearColor];
    [headerViewThree setUserInteractionEnabled:NO];

    [stepThree addSubview:headerViewThree];
    
    /*UITextView *subHeaderViewThree = [[UITextView alloc] initWithFrame:CGRectMake(10, 285, (self.view.frame.size.width - 20), 50)];
    subHeaderViewThree.text = @"Recipes and tips you like get saved to your profile for later viewing.";
    [subHeaderViewThree setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    subHeaderViewThree.backgroundColor = [UIColor clearColor];
    [subHeaderViewThree setUserInteractionEnabled:NO];
    [stepThree addSubview:subHeaderViewThree];*/
    
    
    NSArray *views = [[NSArray alloc] initWithObjects:stepOne, stepTwo, stepThree, nil];
    
    //add pages to scrollview
    [scrollView addPages:views];
    
    //add scrollview to the view
    [self.view addSubview:scrollView];
    
    scrollView.center = CGPointMake( self.view.bounds.size.width / 2, (self.view.bounds.size.height - 100) / 2);

    
    [scrollView setHasPageControl:YES];
    
}

//- (IBAction)loginButtonPushed:(UIButton *)sender {
//    sproutsViewController *mainView = [[sproutsViewController alloc] init];
//    [self.navigationController pushViewController:mainView animated:YES];
//}


- (IBAction)loginButtonPushed:(UIButton *)sender {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"email"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else {
            
            if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            
            // Create request for user's Facebook data
            FBRequest *request = [FBRequest requestForMe];
            
            // Send request to Facebook
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // result is a dictionary
                    NSDictionary *userData = (NSDictionary *)result;
                    
                    // show all data from Facebook
                    for (id key in userData) {
                        NSLog(@"key: %@, value: %@", key, [userData objectForKey:key]);
                    }
                    
                    // save user data to Parse
                    PFUser *currentUser = [PFUser currentUser];
                    [currentUser setObject:[userData objectForKey:@"first_name"] forKey:@"firstName"];
                    [currentUser setObject:[userData objectForKey:@"last_name"] forKey:@"lastName"];
                    [currentUser setObject:[userData objectForKey:@"email"] forKey:@"email"];
                    
                    NSString *facebookId = userData[@"id"];
                    
                    // save profile pic
                    self.imageData = [[NSMutableData alloc] init];
                    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=240&height=240", facebookId]];
                    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
                    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:profilePictureURLRequest delegate:self];
                    if (!urlConnection) {
                        NSLog(@"Failed to download picture");
                    }
                    
                    [currentUser saveInBackground];
                    
                }
            }];
            
            [self performSegueWithIdentifier:@"loginToMain" sender:self];
        }
    }];
}

// Asynchronous image download + save to Parse

// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    PFFile *imageFile = [PFFile fileWithName:@"profile.png" data:self.imageData];
    [imageFile saveInBackground];
    PFUser *currentUser = [PFUser currentUser];
    [currentUser setObject:imageFile forKey:@"profilePic"];
    [currentUser saveInBackground];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
