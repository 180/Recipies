//
//  Recipe.h
//  GodtRecipes
//
//  Created by Maciej Stanik on 08/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : NSManagedObject

+ (void)fetchRecipies;

@end

NS_ASSUME_NONNULL_END

#import "Recipe+CoreDataProperties.h"
