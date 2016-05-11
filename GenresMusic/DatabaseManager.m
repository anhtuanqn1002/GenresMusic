//
//  DatabaseManager.m
//  GenresMusic
//
//  Created by Nguyen Van Anh Tuan on 12/1/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDB.h"
#import "TrackModel.h"

@interface DatabaseManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DatabaseManager

//using singleton design pattern
+ (instancetype)shareInstance {
    static DatabaseManager *databaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseManager = [[self alloc] init];
    });
    return databaseManager;
}

- (instancetype)init {
    if (self = [super init]) {
        //create database
        NSString *dataName = @"database.db";
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        path = [path stringByAppendingPathComponent:dataName];
        
        //if it does not exists the database, FMDatabase would create a new database
        self.db = [FMDatabase databaseWithPath:path];
        NSLog(@"%@", path);
        
        //opening the database
        [self.db open];
        
        NSString *sql = @"CREATE TABLE IF NOT EXISTS Track (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, trackname TEXT DEFAULT NULL, tracktype INTEGER DEFAULT NULL)";
        //create a table to database
        BOOL result = [self.db executeUpdate:sql];
        
        if (result) {
            NSLog(@"Successfully");
        } else {
            NSLog(@"Failed");
        }
        
        //closing the database
        [self.db close];
        //create table
    }
    return self;
}

- (NSMutableArray *)getListTrack:(NSString *)table forType:(NSInteger)type {
    NSString *sql = [NSString stringWithFormat:@"Select id, trackname, tracktype from %@ where tracktype = %ld", table, type];
    [self.db open];
    FMResultSet *result = [self.db executeQuery:sql];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    while ([result next]) {
        TrackModel *trackmodel = [[TrackModel alloc] init];
        trackmodel.ID = [result intForColumn:@"id"];
        trackmodel.trackname = [result stringForColumn:@"trackname"];
        trackmodel.tracktype = [result intForColumn:@"tracktype"];
        
        NSLog(@"%ld", trackmodel.ID);
        NSLog(@"%@", trackmodel.trackname);
        NSLog(@"%ld", trackmodel.tracktype);
        [temp addObject:trackmodel];
    }
    
    [self.db close];
    return temp;
}

- (BOOL)insertRowOfTable:(NSString *)table withModel:(TrackModel *)model {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (trackname, tracktype) VALUES ('%@', %ld)", table, model.trackname, model.tracktype];
    [self.db open];
    BOOL result = [self.db executeUpdate:sql];
    [self.db close];
    return result;
}

- (BOOL)updateRowOfTable:(NSString *)table withModel:(TrackModel *)model {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ set trackname = '%@', tracktype = %ld where id = %ld",
                     table, model.trackname, model.tracktype, model.ID];
    [self.db open];
    BOOL result = [self.db executeUpdate:sql];
    [self.db close];
    return result;
}

- (BOOL)deleteRowOfTable:(NSString *)table withModel:(TrackModel *)model {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ where id = %ld", table, model.ID];
    [self.db open];
    BOOL result = [self.db executeUpdate:sql];
    [self.db close];
    return result;
}

@end
