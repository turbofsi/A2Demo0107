//
//  AddViewController.m
//  A2Demo0107
//
//  Created by  吕欣韵 on 2015-01-07.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UITextField *txtFood;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.addArray addObject:_txtName.text];
    [self.addArray addObject:_txtAge.text];
    [self.addArray addObject:_txtFood.text];
    
    _txtName.text = nil;
    _txtAge.text = nil;
    _txtFood.text = nil;
    
//    NSLog(@"%@", _addArray);
}


@end
