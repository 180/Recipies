//
//  ConnectionHelper.m
//  GodtRecipes
//
//  Created by Maciej Stanik on 09/02/2016.
//  Copyright © 2016 Maciej Stanik. All rights reserved.
//

#import "ConnectionHelper.h"
#import "Reachability.h"

@implementation ConnectionHelper

+ (BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return networkStatus != NotReachable;
}

@end
