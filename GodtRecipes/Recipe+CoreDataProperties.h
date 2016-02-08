//
//  Recipe+CoreDataProperties.h
//  GodtRecipes
//
//  Created by Maciej Stanik on 08/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipe (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *ingredients;
@property (nullable, nonatomic, retain) NSData *recipeImage;

@end

NS_ASSUME_NONNULL_END
