//
//  APAppItemCollectionViewCell.h
//  AppStore
//
//  Created by Dan Mac Hale on 10/11/2014.
//  Copyright (c) 2014 iElmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APAppItemCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *kind;
@property (nonatomic, weak) IBOutlet UILabel *price;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@end
