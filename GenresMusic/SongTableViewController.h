//
//  SecondViewController.h
//  GenresMusic
//
//  Created by Nguyen Van Anh Tuan on 11/27/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrackModel;
@protocol SongTableViewControllerDelegate <NSObject>

- (void)insertItem:(TrackModel *)item;

@end

#import "GenresTableViewController.h"

@interface SongTableViewController : UITableViewController<GenresTableViewControllerDelegate>

@property (nonatomic, strong) id <SongTableViewControllerDelegate> delegate;

@end

