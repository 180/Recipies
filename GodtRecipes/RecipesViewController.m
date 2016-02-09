//
//  RecipesViewController.m
//  GodtRecipes
//
//  Created by Maciej Stanik on 08/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import "RecipesViewController.h"
#import "ConnectionHelper.h"
#import "Recipe.h"
#import "RecipeCell.h"

static NSString *kCellId = @"RecipeCell";

@interface RecipesViewController ()

@end

@implementation RecipesViewController {
    NSManagedObjectContext *_context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:kCellId bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:kCellId];
    
    if ([ConnectionHelper connected]) {
        [Recipe fetchRecipies];
    }
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
    self.recipes = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
    } else {
        return [_recipes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = (RecipeCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        cell = [[RecipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    
    Recipe *recipe = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        recipe = [_searchResults objectAtIndex:indexPath.row];
    } else {
        recipe = [_recipes objectAtIndex:indexPath.row];
    }
    
    cell.titleLabel.text = recipe.title;
    cell.descriptionLabel.text = recipe.desc;
    cell.ingredientsLabel.text = recipe.ingredients;
    cell.recipeImageView.image = [UIImage imageWithData:recipe.recipeImage];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RecipeCell suggestedCellHeight];
}

#pragma mark - Search

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *ingredientsPredicate = [NSPredicate predicateWithFormat:@"ingredients CONTAINS[c] %@", searchText];
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", searchText];
    NSPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[ingredientsPredicate, titlePredicate]];
    _searchResults = [_recipes filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

@end
