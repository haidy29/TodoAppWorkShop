//
//  SecViewController.h
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ViewController.h"
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property bool filter;

@end

NS_ASSUME_NONNULL_END
