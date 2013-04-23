//
//  sproutsActionViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "sproutsActionViewController.h"
#import "SproutsTabBarController.h"
#import "UIImage+ResizeAdditions.h"
#import "Utility.h"

@interface sproutsActionViewController ()
@property (nonatomic, strong) PFFile *photoFile;
@property (nonatomic, assign) UIBackgroundTaskIdentifier fileUploadBackgroundTaskId;
@property (nonatomic, assign) UIBackgroundTaskIdentifier photoPostBackgroundTaskId;
@end

@implementation sproutsActionViewController

@synthesize ingredientOfTheWeek = _ingredientOfTheWeek;
@synthesize sproutDescription = _sproutDescription;
@synthesize sproutTitle = _sproutTitle;
@synthesize sproutImage = _sproutImage;
@synthesize photoFile;
@synthesize fileUploadBackgroundTaskId;
@synthesize photoPostBackgroundTaskId;
@synthesize sproutScrollView;

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
    
    // Set ingredient of the week text
    PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
    _ingredientOfTheWeek.text = [[ingredient objectForKey:@"name"] lowercaseString];

    // Keyboard up on load
    [_sproutTitle becomeFirstResponder];
    
    // Set Delegates
    [_sproutTitle setDelegate: (id)self];
    [_sproutDescription setDelegate: (id)self];
    
    // Add placeholder
    _sproutDescription.placeholder = @"Add Tip or Description";
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
    _sproutDescription.contentInset = UIEdgeInsetsMake(-8,-8,-8,-8);
    
    float sizeOfContent = 0;
    
    for (int i = 0; i < [[sproutScrollView subviews] count]; i++) {
        UIView *view =[[sproutScrollView subviews] objectAtIndex:i];
        sizeOfContent += view.frame.size.height;
    }
    
    sproutScrollView.contentSize = CGSizeMake(sproutScrollView.frame.size.width, sizeOfContent);
    sproutScrollView.contentInset= UIEdgeInsetsMake(0.0,0.0, 60.0,0.0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 40 || returnKey;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string{
    NSUInteger oldLength = [textView.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 140 || returnKey;
}


// Cancel new Sprout
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Share new Sprout
- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender {
    // Save image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum(_sproutImage.image, nil, nil, nil);
    
    // Title
    NSString *trimmedTitle = [self.sproutTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // Description
    NSString *trimmedDesc = [self.sproutDescription.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //Check photo
    if (!self.photoFile) { // no photo or file not uploaded
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't post your Sprout" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//        [alert show];
//        return;
        NSLog(@"No Photo used");
        //Create and Save Sprout
        NSLog(@"Let's make a Sprout!");
        if (trimmedTitle && trimmedTitle.length != 0) {
            PFObject *sprout = [PFObject objectWithClassName:@"Sprout"];
            [sprout setObject:trimmedTitle forKey:@"title"];
            [sprout setObject:trimmedDesc forKey:@"content"];
            [sprout setObject:[PFUser currentUser] forKey:@"user"];
            [sprout setObject:[[Utility sharedInstance] getCurrentIngredient] forKey:@"ingredient"];
            [sprout setObject:[[Utility sharedInstance] getCurrentWeek] forKey:@"week"];
            
            PFACL *ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [ACL setPublicReadAccess:YES];
            sprout.ACL = ACL;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sproutPosted"
                                                                object:sprout];
            [sprout saveInBackground];
        }
        
    } else { // Yes, there's a photo
        //Create and Save Sprout
        NSLog(@"Let's make a Sprout + Photo!");
//        if (trimmedTitle && trimmedTitle.length != 0) {
        PFObject *sprout = [PFObject objectWithClassName:@"Sprout"];
        [sprout setObject:trimmedTitle forKey:@"title"];
        [sprout setObject:trimmedDesc forKey:@"content"];
        [sprout setObject:self.photoFile forKey:@"photo"];
        [sprout setObject:[PFUser currentUser] forKey:@"user"];
        [sprout setObject:[[Utility sharedInstance] getCurrentIngredient] forKey:@"ingredient"];
        [sprout setObject:[[Utility sharedInstance] getCurrentWeek] forKey:@"week"];
        
        // Sprouts are public, but may only be modified by the user who uploaded them
        PFACL *ACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [ACL setPublicReadAccess:YES];
        sprout.ACL = ACL;
            
//        }
        
        // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
        self.photoPostBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
        }];
        
        // Save Sprout in background
        [sprout saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sprout uploaded");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"sproutPosted"
                                                                    object:sprout];
            } else {
                NSLog(@"Sprout failed to save: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't post your Sprout" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
            [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
        }];
    }
    
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
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    [self shouldUploadImage:editedImage];
}

#pragma mark - ()

- (BOOL)shouldUploadImage:(UIImage *)anImage {
    UIImage *resizedImage = [anImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(560.0f, 560.0f) interpolationQuality:kCGInterpolationHigh];
    // JPEG to decrease file size and enable faster uploads & downloads
    NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.8f);
    
    if (!imageData) {
        return NO;
    }
    
    self.photoFile = [PFFile fileWithData:imageData];
    
    // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
    self.fileUploadBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];
    
    NSLog(@"Requested background expiration task with id %d for Sprouts photo upload", self.fileUploadBackgroundTaskId);
    [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Photo uploaded successfully!");
            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
        }
    }];
    
    return YES;
}

@end









