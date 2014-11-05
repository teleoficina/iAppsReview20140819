//
//  FiveStarView.m
//  iRateFlyer
//
//  Created by Kevin McNeish on 3/18/13.
//  Copyright (c) 2013 Oak Leaf Enterprises, Inc. All rights reserved.
//	Adapted from Ray Wenderlich's Star Rating View

#import "mmStarRating.h"

@implementation mmStarRating

- (void)baseInit {

	// Initialize property settings
    _rating = 0;
    _editable = YES;
    _imageViews = [[NSMutableArray alloc] init];
    _maxRating = 5;
    _midMargin = 5;
    _leftMargin = 0;
	_labelMargin = 0;
    _minImageSize = CGSizeMake(5, 5);
    _delegate = nil;
	_unselectedImage = [UIImage imageNamed:@"star.png"];
    _halfSelectedImage = [UIImage imageNamed:@"halfstar.png"];
    _selectedImage = [UIImage imageNamed:@"fullstar.png"];
	_ratingText = [[NSMutableArray
					alloc] initWithObjects:@"Terrible",
				   @"Poor",
				   @"Average",
				   @"Very Good",
				   @"Excellent", nil];
	_displayRatingText = YES;
	self.backgroundColor = [UIColor clearColor];
	
	[self createImageViews];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (void)refresh {
    for(int i = 0; i < self.imageViews.count; ++i) {

        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (self.rating >= i+1) {
            imageView.image = self.selectedImage;
        } else if (self.rating > i) {
            imageView.image = self.halfSelectedImage;
        } else {
            imageView.image = self.unselectedImage;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.unselectedImage)
	{
		float desiredImageWidth = (self.frame.size.width -
								   (self.leftMargin * 2) -
								   (self.midMargin * self.imageViews.count)) /
		self.imageViews.count;
		float imageWidth = MAX(self.minImageSize.width, desiredImageWidth);
		float imageHeight = MAX(self.minImageSize.height, self.frame.size.height - self.labelMargin - 21);

		UIImageView *imageView;
		for (int i = 0; i < self.imageViews.count; ++i) {

			imageView = [self.imageViews objectAtIndex:i];
			CGRect imageFrame = CGRectMake(self.leftMargin + i*(self.midMargin+imageWidth), 0, imageWidth, imageHeight);
			imageView.frame = imageFrame;
		}

		if (self.displayRatingText) {

			

			[self.ratingLabel removeFromSuperview];
			self.ratingLabel = [[UILabel alloc] init];
			CGRect labelFrame = CGRectMake(self.leftMargin,
										   //self.frame.size.height - 21,
										   imageView.frame.origin.y + self.labelMargin + imageView.frame.size.height,
											   //self.frame.size.height,
											   self.frame.size.width,
											   21);
			self.ratingLabel.frame = labelFrame;
			self.ratingLabel.backgroundColor = [UIColor clearColor];
			self.ratingLabel.textColor = [UIColor blackColor];
			self.ratingLabel.textAlignment = NSTextAlignmentCenter;
			self.hidden = false;

			self.ratingLabel.text = @"Tap to Rate";
			[self addSubview:self.ratingLabel];
		}
	}
}

- (void)setMaxRating:(int)maxRating {
    _maxRating = maxRating;
	[self createImageViews];
}

- (void)createImageViews
{
	// Remove old image views
    for(int i = 0; i < self.imageViews.count; ++i) {
        UIImageView *imageView = (UIImageView *) [self.imageViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [self.imageViews removeAllObjects];
	[self.ratingLabel removeFromSuperview];

    // Add new image views
    for(int i = 0; i < _maxRating; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }

	if (self.displayRatingText) {
		self.ratingLabel = [[UILabel alloc] init];
		[self addSubview:self.ratingLabel];
	}

    // Relayout and refresh
    [self setNeedsLayout];
    [self refresh];
}

- (void)setRating:(float)rating {
    _rating = rating;
    [self refresh];
	[self setRatingText];
}

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    if (!self.editable) return;

    int newRating = 1;	// Set the minimum rating
    for(int i = self.imageViews.count - 1; i >= 0; i--) {
		
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (touchLocation.x > imageView.frame.origin.x) {
            newRating = i+1;
            break;
        }
    }

    self.rating = newRating;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate starRating:self ratingDidChange:self.rating];
	[self setRatingText];
}

- (void)setRatingText {
	if (self.ratingLabel) {
		int roundedRating = (int)roundf(self.rating);
		roundedRating --;

		self.ratingLabel.text = self.ratingText[roundedRating];
	}
}

@end
