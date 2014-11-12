//
//  APTopRatedCollectionViewController.m
//  AppStore
//
//  Created by Dan Mac Hale on 10/11/2014.
//  Copyright (c) 2014 iElmo. All rights reserved.
//

#import "APTopRatedCollectionViewController.h"
#import "AFNetworking.h"
#import "APAppItemCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface APTopRatedCollectionViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation APTopRatedCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __weak APTopRatedCollectionViewController *blockSelf = self;
    [manager GET:@"https://itunes.apple.com/gb/rss/topgrossingapplications/limit=25/json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *itemDictionary = [responseObject valueForKeyPath:@"feed.entry"];
        for (NSDictionary *item in itemDictionary) {
            [blockSelf.items addObject:item];
        }
        [blockSelf.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APAppItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"APAppItemCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *item = self.items[indexPath.row];
    cell.name.text = [item valueForKeyPath:@"im:name.label"];
    cell.kind.text = [item valueForKeyPath:@"category.attributes.label"];
    cell.price.text = [item valueForKeyPath:@"im:price.attributes.amount"];
    NSArray *itemImages = [item valueForKeyPath:@"im:image"];
    NSString *imageUrlString = [[itemImages lastObject] objectForKey:@"label"];
    [cell.image setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:nil];
    return cell;
}

#pragma mark - UICollectionView Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

@end
