//
//  AddViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "AddViewController.h"

@interface AddViewController ()

@end
@implementation AddViewController
{
}
static NSMutableArray *todo;

+ (void)initialize{
    todo = [NSMutableArray new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _def = [NSUserDefaults standardUserDefaults];

}

- (IBAction)addBut:(id)sender {
    
    if((_lbltitle.text.length > 0) && !([_lbldescription.text isEqualToString:@""])){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add" message:@"Add New Task?" preferredStyle: UIAlertControllerStyleActionSheet];
        
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSData *data2 = [_def objectForKey:@"Task"];
            todo=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
            
            Task *task2 = [Task new];
            task2.t_name = _lbltitle.text;
            task2.t_des = _lbldescription.text;
            task2.t_date = _date.date;
            
            if(self.priority.selectedSegmentIndex == 0){
                task2.t_img = @"low";
                task2.t_priority = @"Low";
            }else if (self.priority.selectedSegmentIndex == 1){
                task2.t_img = @"medium";
                task2.t_priority = @"Medium";
            }else if(self.priority.selectedSegmentIndex == 2){
                task2.t_img = @"high2";
                task2.t_priority = @"High";
                
            }
            
            
            [todo addObject:task2];
            
            NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:todo];
            [_def setObject:data forKey:@"Task"];
            //[self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:(NO)];
        }];
        
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:yes];
        [alert addAction:no];
        
        [self presentViewController:alert animated:YES completion:^{
            printf("alert done \n");
        }];
    }
    else{
        UIAlertController *empty_alert = [UIAlertController alertControllerWithTitle:@"Empty Task" message:@"Please Add the Title And Description" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [empty_alert addAction: ok];
        [self presentViewController:empty_alert animated:YES completion:nil];
        
    }
    
    // ViewController *f = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
}




@end
