//
//  ViewController.m
//  A2Demo0107
//
//  Created by  吕欣韵 on 2015-01-07.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "CheckViewController.h"
#import "LoadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exitAction:(UIButton *)sender {
    exit(0);
}

- (IBAction)storageAction:(UIButton *)sender {
    UIAlertView *alertShow = [[UIAlertView alloc] initWithTitle:@"Save This File?"
                                                        message:@"Please Enter The File Name"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Confirm", nil];
    alertShow.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertShow show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField *tf = [alertView textFieldAtIndex:0];
    NSString *fileName = tf.text;
    
    if (buttonIndex == 1 && tf.text != nil) {
        
//      get the path for directory and write array to it
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docFolder = path[0];
        NSString *pathName = [NSString stringWithFormat:@"%@.plist", fileName];
        NSLog(@"path name is: %@", fileName);
        NSString *filePath = [docFolder stringByAppendingString:pathName];
        [_currentArray writeToFile:filePath atomically:YES];

        
//      store the name of the the file.
        NSString *docNamespath = [docFolder stringByAppendingString:@"dataBase.plist"];
        NSMutableArray *docArray = [NSMutableArray arrayWithContentsOfFile:docNamespath];
        if (docArray == NULL) {
            NSMutableArray *iniArray = [[NSMutableArray alloc] init];
            [iniArray writeToFile:docNamespath atomically:YES];
            docArray = iniArray;
        }
        
        [docArray addObject:fileName];
        [docArray writeToFile:docNamespath atomically:YES];
        
        NSArray *testArray = [NSArray arrayWithContentsOfFile:docNamespath];
        NSLog(@"%@", testArray);
        
        NSLog(@"File stored at: %@", filePath);
//
//        NSArray *testArray = [NSArray arrayWithContentsOfFile:filePath];
//        NSLog(@"%@", testArray);
    }
}


-(IBAction)unwindToMainVC:(UIStoryboardSegue *)segue{
    
    AddViewController *addVC = [segue sourceViewController];
    [self.currentArray addObjectsFromArray:addVC.addArray];
//    
//    NSLog(@"%@", self.currentArray);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MainToCheck"]) {
        CheckViewController *CheckVC = [segue destinationViewController];
        CheckVC.showArray = [[NSArray alloc] initWithArray:_currentArray];
    }
    if ([[segue identifier] isEqualToString:@"MainToLoad"]) {
        LoadViewController *loadVC = [segue destinationViewController];
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *docFolder = path[0];
        NSString *docNamespath = [docFolder stringByAppendingString:@"dataBase.plist"];
        NSMutableArray *docArray = [NSMutableArray arrayWithContentsOfFile:docNamespath];
        
        loadVC.loadDocArray = docArray;

    }
    
}

@end
