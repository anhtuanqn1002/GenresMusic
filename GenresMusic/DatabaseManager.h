//
//  DatabaseManager.h
//  GenresMusic
//
//  Created by Nguyen Van Anh Tuan on 12/1/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TrackModel;
@interface DatabaseManager : NSObject

+ (instancetype)shareInstance;
- (NSMutableArray *)getListTrack:(NSString *)table forType:(NSInteger)type;
- (BOOL)insertRowOfTable:(NSString *)table withModel:(TrackModel *)model;
- (BOOL)updateRowOfTable:(NSString *)table withModel:(TrackModel *)model;
- (BOOL)deleteRowOfTable:(NSString *)table withModel:(TrackModel *)model;

@end
