//
//  RecipeCell.h
//  GodtRecipes
//
//  Created by Maciej Stanik on 09/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;

+ (int)suggestedCellHeight;

@end
