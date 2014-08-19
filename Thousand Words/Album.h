//
//  Album.h
//  Thousand Words
//
//  Created by yousheng chang on 8/18/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;

@end
