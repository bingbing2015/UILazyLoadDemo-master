//
//  ViewController.m
//  UILazyLoadingDemo
//
//  Created by 刘浩 on 15/7/18.
//  Copyright (c) 2015年 castel. All rights reserved.
//

/*
 1.懒加载基本
 
 懒加载——也称为延迟加载，即在需要的时候才加载（效率低，占用内存小）。所谓懒加载，写的是其get方法.
 
 注意：如果是懒加载的话则一定要注意先判断是否已经有了，如果没有那么再去进行实例化
 
 2.使用懒加载的好处：
 
 （1）不必将创建对象的代码全部写在viewDidLoad方法中，代码的可读性更强
 
 （2）每个控件的getter方法中分别负责各自的实例化处理，代码彼此之间的独立性强，松耦合
 
 
 */


#import "ViewController.h"

#define POTOIMGW    200
#define POTOIMGH    300
#define POTOIMGX    60
#define  POTOIMGY   50

@interface ViewController ()

@property(nonatomic,strong)UILabel *firstlab;
@property(nonatomic,strong)UILabel *lastlab;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UIButton *rightbtn;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic ,assign)int i;


-(void)change;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [super viewDidLoad];
    [self change];
}

-(void)change
{
    [self.firstlab setText:[NSString stringWithFormat:@"%d/5",self.i+1]];
 //先get再set
//     self.icon.image=[UIImage imageNamed:self.array[self.i][@"name"]];
//     self.lastlab.text=self.array[self.i][@"desc"];
    self.lastlab.text=self.array[self.i];
    
    self.leftbtn.enabled=(self.i!=0);
    
    self.rightbtn.enabled=(self.i!=4);
}

//延迟加载
/**1.图片的序号标签*/
-(UILabel *)firstlab
 {
    //判断是否已经有了，若没有，则进行实例化
     
    if (!_firstlab) {
        
        _firstlab=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 300, 30)];
        [_firstlab setTextAlignment:NSTextAlignmentCenter];
        _firstlab.layer.cornerRadius = 10;
        _firstlab.layer.borderWidth = 1;
        [self.view addSubview:_firstlab];
        
       }
     
     return _firstlab;
}



/**2.图片控件的延迟加载*/
-(UIImageView *)icon
{
     //判断是否已经有了，若没有，则进行实例化
  if (!_icon) {
        _icon=[[UIImageView alloc]initWithFrame:CGRectMake(POTOIMGX, POTOIMGY, POTOIMGW, POTOIMGH)];
       UIImage *image=[UIImage imageNamed:@"biaoqingdi"];
      _icon.layer.cornerRadius = 10;
      _icon.layer.borderWidth = 1;
        _icon.image=image;
       [self.view addSubview:_icon];
    }
        return _icon;
}


/**3.描述控件的延迟加载*/
 -(UILabel *)lastlab
{
    //判断是否已经有了，若没有，则进行实例化
    if (!_lastlab) {
        _lastlab=[[UILabel alloc]initWithFrame:CGRectMake(20, 400, 300, 30)];
        [_lastlab setTextAlignment:NSTextAlignmentCenter];
        _lastlab.layer.cornerRadius = 10;
        _lastlab.layer.borderWidth = 1;
        [self.view addSubview:_lastlab];
  }
      return _lastlab;
}


/**4.左键按钮的延迟加载*/
-(UIButton *)leftbtn
{
     //判断是否已经有了，若没有，则进行实例化
  if (!_leftbtn) {
      _leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
      _leftbtn.frame=CGRectMake(20, self.view.center.y, 40, 40);
      [_leftbtn setTitle:@"左边" forState:UIControlStateNormal];
      [_leftbtn setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
      [_leftbtn setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted];
      _leftbtn.layer.cornerRadius = 10;
      _leftbtn.layer.borderWidth = 1;
      
      [self.view addSubview:_leftbtn];
      [_leftbtn addTarget:self action:@selector(leftclick:) forControlEvents:UIControlEventTouchUpInside];

     }
   return _leftbtn;

 }

/**5.右键按钮的延迟加载*/
-(UIButton *)rightbtn
 {
       if (!_rightbtn) {
            _rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            _rightbtn.frame=CGRectMake(POTOIMGX+POTOIMGW+10, self.view.center.y, 40, 40);
           [_rightbtn setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
           [_rightbtn setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
           _rightbtn.layer.cornerRadius = 10;
           _rightbtn.layer.borderWidth = 1;
           [self.view addSubview:_rightbtn];
           
           [_rightbtn addTarget:self action:@selector(rightclick:) forControlEvents:UIControlEventTouchUpInside];
           }
    
     
     return _rightbtn;
    
 }


 //array的get方法
-(NSArray *)array
 {
     if (_array==nil) {
        
         NSString *path=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        
         _array=[[NSArray alloc]initWithContentsOfFile:path];
   }
     
 
     return _array;
 
 }

//按钮点击事件
//左侧
- (void)leftclick:(UIButton *)btn
{

    self.i--;
    
    [self change];
}
//右侧
- (void)rightclick:(UIButton *)btn
{
    
    self.i++;
    
    [self change];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
