//
//  LoginView.m
//  LoginDemo
//
//  Created by Get-CC on 16/2/15.
//  Copyright © 2016年 shifengming. All rights reserved.
//

#import "LoginView.h"

#define kWindowWidth [UIScreen mainScreen].bounds.size.width
#define kWindowHeigth [UIScreen mainScreen].bounds.size.height
#define kLabelHeight 50
#define x_OffSet 20

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLoginUI];
    }
    return self;
}

- (void)setLoginUI
{
    _topTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kLabelHeight)];
    _topTitleLable.center = CGPointMake(kWindowWidth/2, kWindowHeigth/4);
    _topTitleLable.text = @"Hey,iOSer";
    _topTitleLable.font = [UIFont fontWithName:@"Helvetica-Oblique" size:28];
    _topTitleLable.textAlignment = NSTextAlignmentCenter;
    _topTitleLable.textColor = [UIColor blackColor];
    [self addSubview:_topTitleLable];
    
    CGFloat btnWidth = (kWindowWidth-4*x_OffSet)/2;
    _registBtn = [[UIButton alloc]initWithFrame:CGRectMake(x_OffSet*2, kWindowHeigth-100, btnWidth-x_OffSet/2, 44)];
    [_registBtn setTitle:@"注册" forState:0];
    _registBtn.layer.cornerRadius = 5.0f;
    [_registBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [_registBtn setBackgroundColor:[[UIColor whiteColor]colorWithAlphaComponent:0.8f]];
//    [self addSubview:_registBtn];
    
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_registBtn.frame)+x_OffSet,kWindowHeigth-100, btnWidth-x_OffSet/2, 44)];
    [_loginBtn setTitle:@"登录" forState:0];
    _loginBtn.layer.cornerRadius = 5.0f;
    [_loginBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    [_loginBtn setBackgroundColor:[[UIColor whiteColor]colorWithAlphaComponent:0.8f]];
//    [self addSubview:_loginBtn];
    
    _userNameTextView = [[ImageAndTextFieldView alloc]initWithFrame:CGRectMake(x_OffSet, kWindowWidth*2/3, kWindowWidth-x_OffSet*2, 47)];
    _userNameTextView.placeholdString = @"请输入手机号或者邮箱";
    _userNameTextView.image = [UIImage imageNamed:@"icon_phone_select@2x"];
    [self addSubview:_userNameTextView];
    
    _passwordTextView = [[ImageAndTextFieldView alloc]initWithFrame:CGRectMake(x_OffSet, CGRectGetMaxY(_userNameTextView.frame)+5, kWindowWidth-x_OffSet*2-120, 47)];
    _passwordTextView.placeholdString = @"请输入验证码";
    _passwordTextView.inputTextField.secureTextEntry = YES;
    _passwordTextView.image = [UIImage imageNamed:@"icon_code_select@2x"];
    [self addSubview:_passwordTextView];
    //添加获取验证码按钮
     _getSMSBtn = [[UIButton alloc]initWithFrame:CGRectMake(x_OffSet+_passwordTextView.frame.size.width +20, _passwordTextView.frame.origin.y,100 , 47)];
    [_getSMSBtn setTitle:@"获取验证码" forState:0];
    [_getSMSBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_getSMSBtn setBackgroundColor:[UIColor colorWithRed:0 green:0.71 blue:0.54 alpha:1]];
    _getSMSBtn.layer.cornerRadius = 5.0f;
    _getSMSBtn.layer.borderWidth = 1.0f;
    _getSMSBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:_getSMSBtn];
//    [_getSMSBtn addTarget:self action:@selector(GetSMS:) forControlEvents:UIControlEventTouchUpOutside];
    
    _makesureRegistBtn = [[UIButton alloc]initWithFrame:CGRectMake(x_OffSet, CGRectGetMaxY(_passwordTextView.frame)+x_OffSet, kWindowWidth-x_OffSet*2, 44)];
    [_makesureRegistBtn setTitle:@"登陆" forState:0];
    [_makesureRegistBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_makesureRegistBtn setBackgroundColor:[UIColor colorWithRed:0 green:0.71 blue:0.54 alpha:1]];
    _makesureRegistBtn.layer.cornerRadius = 5.0f;
    _makesureRegistBtn.layer.borderWidth = 1.0f;
    _makesureRegistBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:_makesureRegistBtn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)GetSMS:(UIButton *)getSMSBtn{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [getSMSBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                //设置不可点击
                getSMSBtn.userInteractionEnabled = YES;
                getSMSBtn.backgroundColor = [UIColor orangeColor];
                
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [getSMSBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                //设置可点击
                getSMSBtn.userInteractionEnabled = NO;
                getSMSBtn.backgroundColor = [UIColor lightGrayColor];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}


@end
