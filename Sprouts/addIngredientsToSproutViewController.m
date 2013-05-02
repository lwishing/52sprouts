//
//  addIngredientsToSproutViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/16/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "addIngredientsToSproutViewController.h"
#import "Names.h"

@interface addIngredientsToSproutViewController (Private)
    - (void)resizeViews;
@end

@implementation addIngredientsToSproutViewController

@synthesize cancelButton, doneButton;

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
    
	//buttons
    UIImage *buttonImage = [[UIImage imageNamed:@"button_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 4, 14, 4)];
    [doneButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [cancelButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	
	tokenFieldView = [[TITokenFieldView alloc] initWithFrame:CGRectMake(0.0f, 108.0f, 2.0f, 20.0f)];
    
	[tokenFieldView setSourceArray:[Names listOfNames]];
	[self.view addSubview:tokenFieldView];
	
	[tokenFieldView.tokenField setDelegate:self];
	[tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldFrameDidChange:) forControlEvents:TITokenFieldControlEventFrameDidChange];
	[tokenFieldView.tokenField setTokenizingCharacters:[NSCharacterSet characterSetWithCharactersInString:@",;."]]; // Default is a comma
	
//	UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//	[addButton addTarget:self action:@selector(showContactsPicker:) forControlEvents:UIControlEventTouchUpInside];
//	[tokenFieldView.tokenField setRightView:addButton];
    
	[tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldChangedEditing:) forControlEvents:UIControlEventEditingDidBegin];
	[tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldChangedEditing:) forControlEvents:UIControlEventEditingDidEnd];
	
//	messageView = [[UITextView alloc] initWithFrame:tokenFieldView.contentView.bounds];
//	[messageView setScrollEnabled:NO];
//	[messageView setAutoresizingMask:UIViewAutoresizingNone];
//	[messageView setDelegate:self];
//	[messageView setFont:[UIFont systemFontOfSize:15]];
//	[messageView setText:@"Some message. The whole view resizes as you type, not just the text view."];
//	[tokenFieldView.contentView addSubview:messageView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	// You can call this on either the view on the field.
	// They both do the same thing.
	[tokenFieldView becomeFirstResponder];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//	[UIView animateWithDuration:duration animations:^{[self resizeViews];}]; // Make it pweeetty.
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//	[self resizeViews];
//}
//
//- (void)showContactsPicker:(id)sender {
//	
//	// Show some kind of contacts picker in here.
//	// For now, here's how to add and customize tokens.
//	
//	NSArray * names = [Names listOfNames];
//	
//	TIToken * token = [tokenFieldView.tokenField addTokenWithTitle:[names objectAtIndex:(arc4random() % names.count)]];
//	[token setAccessoryType:TITokenAccessoryTypeDisclosureIndicator];
//	// If the size of the token might change, it's a good idea to layout again.
//	[tokenFieldView.tokenField layoutTokensAnimated:YES];
//	
//	NSUInteger tokenCount = tokenFieldView.tokenField.tokens.count;
//	[token setTintColor:((tokenCount % 3) == 0 ? [TIToken redTintColor] : ((tokenCount % 2) == 0 ? [TIToken greenTintColor] : [TIToken blueTintColor]))];
//}

- (void)keyboardWillShow:(NSNotification *)notification {
	
	CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	keyboardHeight = keyboardRect.size.height > keyboardRect.size.width ? keyboardRect.size.width : keyboardRect.size.height;
	[self resizeViews];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	keyboardHeight = 0;
	[self resizeViews];
}

- (void)resizeViews {
    int tabBarOffset = self.tabBarController == nil ?  0 : self.tabBarController.tabBar.frame.size.height;
	[tokenFieldView setFrame:((CGRect){tokenFieldView.frame.origin, {self.view.bounds.size.width, self.view.bounds.size.height + tabBarOffset - keyboardHeight}})];
	[messageView setFrame:tokenFieldView.contentView.bounds];
}

- (BOOL)tokenField:(TITokenField *)tokenField willRemoveToken:(TIToken *)token {
	
//	if ([token.title isEqualToString:@"Tom Irving"]){
//		return NO;
//	}
	
	return YES;
}

- (void)tokenFieldChangedEditing:(TITokenField *)tokenField {
	// There's some kind of annoying bug where UITextFieldViewModeWhile/UnlessEditing doesn't do anything.
	[tokenField setRightViewMode:(tokenField.editing ? UITextFieldViewModeAlways : UITextFieldViewModeNever)];
    
    NSLog(@"array: %@", [tokenField tokenTitles]);
}

- (void)tokenFieldFrameDidChange:(TITokenField *)tokenField {
	[self textViewDidChange:messageView];
}

- (void)textViewDidChange:(UITextView *)textView {
	
	CGFloat oldHeight = tokenFieldView.frame.size.height - tokenFieldView.tokenField.frame.size.height;
	CGFloat newHeight = textView.contentSize.height + textView.font.lineHeight;
	
	CGRect newTextFrame = textView.frame;
	newTextFrame.size = textView.contentSize;
	newTextFrame.size.height = newHeight;
	
	CGRect newFrame = tokenFieldView.contentView.frame;
	newFrame.size.height = newHeight;
	
	if (newHeight < oldHeight){
		newTextFrame.size.height = oldHeight;
		newFrame.size.height = oldHeight;
	}
    
	[tokenFieldView.contentView setFrame:newFrame];
	[textView setFrame:newTextFrame];
	[tokenFieldView updateContentSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
