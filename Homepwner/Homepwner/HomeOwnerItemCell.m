//
//  HomeOwnerItemCell.m
//  Homepwner
//
//  Created by Tammer Saleh on 1/9/12.
//  Copyright (c) 2012 Thunderbolt Labs. All rights reserved.
//

#import "HomeOwnerItemCell.h"
#import "Possession.h"

@implementation HomeOwnerItemCell

@synthesize valueLabel, nameLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setValueLabel:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setNameLabel:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setImageView:[[UIImageView alloc] initWithFrame:CGRectZero]];
        
        [[self contentView] addSubview:[self valueLabel]];
        [[self contentView] addSubview:[self nameLabel]];
        [[self contentView] addSubview:[self imageView]];
        
        [[self imageView] setContentMode:UIViewContentModeCenter];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float inset = 5.0;
    CGRect bounds = [[self contentView] bounds];
    
    float h = bounds.size.height;
    float w = bounds.size.width;
    
    float valueWidth = 40.0;
    
    CGSize thumbnailSize = [Possession thumbnailSize];
    float imageSpace = h - thumbnailSize.height;
        
    CGRect imageFrame = CGRectMake(inset, imageSpace / 2.0, thumbnailSize.width, thumbnailSize.height);
    [[self imageView] setFrame:imageFrame];
    
    CGRect nameFrame = CGRectMake(imageFrame.size.width + imageFrame.origin.x + inset, 
                                  inset, 
                                  w - (h + valueWidth + inset * 4.0), 
                                  h - inset * 2.0);
    [[self nameLabel] setFrame:nameFrame];

    CGRect valueFrame = CGRectMake(nameFrame.size.width + nameFrame.origin.x + inset, 
                                   inset, 
                                   valueWidth, 
                                   h - inset * 2.0);
    [[self valueLabel] setFrame:valueFrame];
}

- (void)setPossession:(Possession *)possession {
    [[self valueLabel] setText:[NSString stringWithFormat:@"$%d", [possession valueInDollars]]];
    [[self nameLabel] setText:[possession possessionName]];
    [[self imageView] setImage:[possession thumbnail]];
}
@end
