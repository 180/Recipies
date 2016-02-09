//
//  RecipesViewController.h
//  GodtRecipes
//
//  Created by Maciej Stanik on 08/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RecipesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong) NSArray *recipes;
@property (strong) NSArray *searchResults;

@end
