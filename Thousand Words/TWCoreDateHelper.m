//
//  TWCoreDateHelper.m
//  Thousand Words
//
//  Created by yousheng chang on 8/18/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TWCoreDateHelper.h"

@implementation TWCoreDateHelper

+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication]delegate];
    
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
    
}
@end
