//
//  Recipe.m
//  GodtRecipes
//
//  Created by Maciej Stanik on 08/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

+ (void)fetchRecipies {
    NSHTTPURLResponse *response = nil;
    
    NSString *urlString = @"http://www.godt.no/api/getRecipesListDetailed?tags=&size=thumbnail-medium&ratio=1&limit=50&from=0";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSError *error;
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    for (NSDictionary *recipeDict in resultDict) {
        Recipe *recipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
        recipe.title = [recipeDict valueForKey:@"title"];
        recipe.desc = [recipeDict valueForKey:@"description"];
        
        
        // Ingredients
        NSString *ingredients = @"";
        
        for (NSDictionary *ingredientDict in [recipeDict valueForKeyPath:@"ingredients.elements"]) {
            
            for (NSString *ingredientName in [ingredientDict valueForKey:@"name"]) {
                ingredients = [NSString stringWithFormat:@"%@%@", ingredients ? ingredients : @"", ingredientName];
            }
        }
        
        recipe.ingredients = ingredients;
        
        // Image
        NSArray *imagesArray = [recipeDict valueForKeyPath:@"images.url"];
        NSString *imageURLString = imagesArray.firstObject;
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        recipe.recipeImage = imageData;
    }
    
    NSError *saveError = nil;
    [context save:&saveError];
}

@end
