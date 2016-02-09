//
//  RecipeCell.m
//  GodtRecipes
//
//  Created by Maciej Stanik on 09/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (int)suggestedCellHeight {
    return 430;
}

@end
