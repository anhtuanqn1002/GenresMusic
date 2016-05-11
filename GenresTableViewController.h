//
//  GenresTableViewController.h
//  GenresMusic
//
//  Created by Nguyen Van Anh Tuan on 11/27/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrackModel;
@protocol GenresTableViewControllerDelegate <NSObject>

- (void)insertItem:(TrackModel *)item;

@end

#import "SongTableViewController.h"

@interface GenresTableViewController : UITableViewController<SongTableViewControllerDelegate>

@property (nonatomic, strong) id <GenresTableViewControllerDelegate> delegate;

@end
