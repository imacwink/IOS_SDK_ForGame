//
//  ViewController.m
//  XYSDKDebug
//
//  Created by 王云刚 on 2018/3/10.
//  Copyright © 2018年 tencent. All rights reserved.
//

#import "ViewController.h"
#import <XYSDK/XYSDK.h>
#import <objc/message.h>

@interface ViewController()
{
    __weak id reference;
}
@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
     NSLog(@"%@", NSStringFromClass([self superclass]));
    
    XYSDKParam * param = [[XYSDKParam alloc] init];
    param.appID = @"123456";
    param.appSecret = @"FFFDDDSSSQQQ";
    param.appSecretKey = @"1429184789174";
    [[XYSDKInstance sharedInstance] init:param];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // NSLog(@"%@", reference); // Console: sunnyxx
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //NSLog(@"%@", reference); // Console: (null)
}

- (void)testButton{
    //NSLog(@"testButton : %@", reference);
    
    NSLog(@"－－－%@",[NSThread callStackSymbols]);
    
    
    NSLog(@"－－－%@",[NSThread callStackReturnAddresses]);
}

- (void)testButton:(NSString *)info{
    NSLog(@"testButton : %@", reference);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openXYSDKEvent:(id)sender {
    [[XYSDKInstance sharedInstance] open:self];
}

@end
