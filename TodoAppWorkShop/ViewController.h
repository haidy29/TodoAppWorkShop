//
//  ViewController.h
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextField *txt;

@end

