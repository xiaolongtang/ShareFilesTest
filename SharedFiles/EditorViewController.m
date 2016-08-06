//
//  EditorViewController.m
//  SharedFiles
//
//  Created by 晓龙 唐 on 15/12/14.
//  Copyright © 2015年 txl. All rights reserved.
//

#import "EditorViewController.h"
#import "ZSSDemoPickerViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CCLOG(@"running...%@",_idStr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    
    // Export HTML
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    
    // HTML Content to set in the editor
    NSString *html = @"<!-- This is an HTML comment -->"
    "<p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title=\"Zed Said\" href=\"http://www.zedsaid.com\">Zed Said Studio</a></p>";
    
    // Set the base URL if you would like to use relative links, such as to images.
//    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    self.shouldShowKeyboard = YES;
    // Set the HTML contents of the editor
    [self setHTML:html];
    
}

- (void)exportHTML {
    
    NSLog(@"%@", [self getHTML]);
    
}

- (void)showInsertURLAlternatePicker {
    
    [self dismissAlertView];
    
    ZSSDemoPickerViewController *picker = [[ZSSDemoPickerViewController alloc] init];
    picker.demoView = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)showInsertImageAlternatePicker {
    
    [self dismissAlertView];
    
    ZSSDemoPickerViewController *picker = [[ZSSDemoPickerViewController alloc] init];
    picker.demoView = self;
    picker.isInsertImagePicker = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
