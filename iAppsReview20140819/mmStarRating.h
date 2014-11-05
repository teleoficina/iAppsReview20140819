//
//  FiveStarView.h
//  iRateFlyer
//
//  Created by Kevin McNeish on 3/18/13.
//  Copyright (c) 2013 Oak Leaf Enterprises, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mmStarRating;

@protocol StarRatingDelegate
-(void)starRating:(mmStarRating *)starRating ratingDidChange:(float)rating;
@end

@interface mmStarRating : UIView

// Image of unselected star
@property (strong, nonatomic) UIImage *unselectedImage;
// Image of half-selected star
@property (strong, nonatomic) UIImage *halfSelectedImage;
// Image of selected star
@property (strong, nonatomic) UIImage *selectedImage;
// The current rating
@property (assign, nonatomic) float rating;
// An array of default rating text
// 1 star - Terrible, 2 star - Poor, 3-star - Average
// 4 star - Very Good, 5 star - Excellent
// You can store your own custo text into this array
@property (strong, nonatomic) NSMutableArray *ratingText;
// Specifies if the user can change the rating by
// clicking on the stars (true by default)
@property (assign) BOOL editable;
// An array of image views that display the stars
@property (strong) NSMutableArray * imageViews;
// The maximum rating (default = 5)
@property (assign, nonatomic) int maxRating;
// The margin between the stars
@property (assign) int midMargin;
// The margin on the left side of the stars
@property (assign) int leftMargin;
// The margin between the stars and the label
@property (assign) int labelMargin;
// Minimum image size (5x5 by default)
@property (assign) CGSize minImageSize;
// A reference to the delegate which is called when
// the user taps one of the stars
@property (assign) id <StarRatingDelegate> delegate;
// Contains a reference to the rating label
@property (strong, nonatomic) UILabel *ratingLabel;
// Specifies if rating text should be displayed
@property (assign) BOOL displayRatingText;

@end
