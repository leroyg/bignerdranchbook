//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"
#import "ImageStore.h"

@implementation ItemDetailViewController
@synthesize nameField;
@synthesize serialNumberField;
@synthesize valueField;
@synthesize dateLabel;
@synthesize imageView;
@synthesize possession;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
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
    [valueField setText:[NSString stringWithFormat:@"%d", [[self possession] valueInDollars]]];
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
    [[self possession] setPossessionName:[nameField text]];
    [[self possession] setSerialNumber:[serialNumberField text]];
    [[self possession] setValueInDollars:[[valueField text] intValue]];
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePicker setDelegate:self];
    [self presentModalViewController:imagePicker animated:YES];
    
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
    [self dismissModalViewControllerAnimated:YES];
}
@end
