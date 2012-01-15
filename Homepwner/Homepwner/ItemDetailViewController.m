//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"
#import "PossessionStore.h"
#import "ImageStore.h"

@implementation ItemDetailViewController
@synthesize nameField;
@synthesize serialNumberField;
@synthesize valueField;
@synthesize dateLabel;
@synthesize imageView;
@synthesize possession;
@synthesize imagePickerPopover;
@synthesize delegate;

- (id)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:@"ItemDetailViewController" bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw [NSException exceptionWithName:@"wrong init" reason:@"use initForNewItem" userInfo:nil];
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *clr = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        clr = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    } else {
        clr = [UIColor groupTableViewBackgroundColor];
    }
    
    [[self view] setBackgroundColor:clr];
}

- (void)viewDidUnload {
    [self setNameField:nil];
    [self setSerialNumberField:nil];
    [self setValueField:nil];
    [self setDateLabel:nil];
    [self setImageView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [nameField setText:[[self possession] possessionName]];
    [serialNumberField setText:[[self possession] serialNumber]];
    
    if ([possession valueInDollars]) {
        [valueField setText:[NSString stringWithFormat:@"%@", [[self possession] valueInDollars]]];        
    } else {
        [valueField setText:@"0"];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [dateLabel setText:[formatter stringFromDate:[[self possession] dateCreated]]];
    [[self navigationItem] setTitle:[[self possession] possessionName]];
    NSString *imageKey = [possession imageKey];
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore defaultImageStore] imageForKey:imageKey];
        [imageView setImage:imageToDisplay];
    } else {
        [imageView setImage:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    [possession setPossessionName:[nameField text]];
    [possession setSerialNumber:[serialNumberField text]];
    NSNumber *num = [NSNumber numberWithInt:[[valueField text] intValue]];
    [possession setValueInDollars:num];
}

- (IBAction)save:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    if ([delegate respondsToSelector:@selector(itemDetailViewControllerWillDismiss:)]) {
        [delegate itemDetailViewControllerWillDismiss:self];
    }
}

- (IBAction)cancel:(id)sender {
    [[PossessionStore defaultStore] removePossession:[self possession]];
    [self dismissModalViewControllerAnimated:YES];
    if ([delegate respondsToSelector:@selector(itemDetailViewControllerWillDismiss:)]) {
        [delegate itemDetailViewControllerWillDismiss:self];
    }
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePicker setDelegate:self];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self setImagePickerPopover:[[UIPopoverController alloc] initWithContentViewController:imagePicker]];
        [[self imagePickerPopover] setDelegate:self];
        [[self imagePickerPopover] presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentModalViewController:imagePicker animated:YES];        
    }
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)removePicture:(id)sender {
    if ([[self possession] imageKey]) {
        [[ImageStore defaultImageStore] deleteImageForKey:[[self possession] imageKey]];
        [[self possession] setImageKey:nil];
    }
    [imageView setImage:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *oldKey = [possession imageKey];
    if (oldKey) {
        [[ImageStore defaultImageStore] deleteImageForKey:oldKey];
    }
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    [possession setImageKey:(__bridge NSString *)newUniqueIDString];
    CFRelease(newUniqueID);
    CFRelease(newUniqueIDString);
    [[ImageStore defaultImageStore] setImage:image forKey:[possession imageKey]];
    
    [imageView setImage:image];
    [possession setThumbnailDataFromImage:image];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];        
    } else {
        [[self imagePickerPopover] dismissPopoverAnimated:YES];
        [self setImagePickerPopover:nil];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    }
    
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [self setImagePickerPopover:nil];
}

@end
