//
//  ListViewController.h
//  TableTheardsOne
//
//  Created by nn on 13-5-22.
//  Copyright (c) 2013年 ssn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

#define kDataURLString @"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"

@interface ListViewController : UITableViewController

@property (nonatomic, retain)NSDictionary *photos;
@end
