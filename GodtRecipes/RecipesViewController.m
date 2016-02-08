//
//  RecipesViewController.m
//  GodtRecipes
//
//  Created by Maciej Stanik on 08/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import "RecipesViewController.h"
#import "Recipe.h"

@interface RecipesViewController ()

@end

@implementation RecipesViewController {
    NSManagedObjectContext *_context;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Recipe fetchRecipies];
    
    [self showData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showData {
    _context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        _context = [delegate managedObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Recipe"];
    self.recipies = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_recipies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    Recipe *recipe = [_recipies objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:1];
    [titleLabel setText: recipe.title];
    
    UILabel *descriptionLabel = (UILabel *)[cell.contentView viewWithTag:2];
    [descriptionLabel setText:recipe.desc];
    
    UILabel *ingredientsLabel = (UILabel *)[cell.contentView viewWithTag:3];
    [ingredientsLabel setText:recipe.ingredients];
    
    UIImageView *recipeImageView = (UIImageView *)[cell.contentView viewWithTag:4];
    recipeImageView.image = [UIImage imageWithData:recipe.recipeImage];
    
    return cell;
}


@end
