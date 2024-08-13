//
//  ThirdViewController.h
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThirdViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property int index_done;
@property bool filter;

@end

NS_ASSUME_NONNULL_END
