//
//  sproutsActionViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "sproutsActionViewController.h"
#import "SproutsTabBarController.h"

@interface sproutsActionViewController ()

@end

@implementation sproutsActionViewController

@synthesize ingredientOfTheWeek = _ingredientOfTheWeek;
@synthesize sproutDescription = _sproutDescription;
@synthesize sproutTitle = _sproutTitle;
@synthesize sproutImage = _sproutImage;

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
    [_sproutTitle becomeFirstResponder];
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Cancel new Sprout
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Share new Sprout
- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender {
    // Save image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum(_sproutImage.image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Add photo to Sprout
- (IBAction)photoButtonPressed:(UIButton *)sender {
    // Create UIActionSheet with options to Take Photo or Choose Existing
    UIActionSheet *photoOptions = [[UIActionSheet alloc]initWithTitle:@"Add a photo to your Sprout" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Existing", nil];
    [photoOptions showInView:self.view];
}
 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    switch (buttonIndex) {
        // Take Photo
        case 0:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }
            break;
        // Choose Existing
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }
            break;
        default:
            break;
    }
}

// Dismiss UIImagePickerController if user taps Cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Dismiss UIImagePickerController if user selects an image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Save cropped image
    UIImage *editedImage;
    editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
    
    // Dismiss UIImagePickerController
    [picker dismissViewControllerAnimated:YES completion:NULL];
    _sproutImage.image = editedImage;
}

@end









