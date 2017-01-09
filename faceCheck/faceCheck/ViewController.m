//
//  ViewController.m
//  faceCheck
//
//  Created by INTCO 王伟 on 2017/1/5.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView * faceImageView;

@property (nonatomic,strong) UIButton * findFaceButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(130, 20, 90, 40)];
    
    btn.backgroundColor = [UIColor darkGrayColor];
    
    [btn setTitle:@"FaceCheck" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(faceCheckAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView * faceV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, 180, 230)];
    
    faceV.backgroundColor = [UIColor lightGrayColor];
    self.faceImageView    = faceV;
    [self.view addSubview:faceV];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 300, 60)];
    self.findFaceButton = button;
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

- (void) faceCheckAction{

      /// 不能识别侧脸  、 识别效果差
      // > 要识别的图片
        UIImage * image = [UIImage  imageNamed:@"fachCheck"];
        CIImage * coreImage = [[CIImage alloc] initWithImage:image];
        CIContext * context = [CIContext contextWithOptions:nil];
        CIDetector * detector = [CIDetector detectorOfType:@"CIDetectorTypeFace"context:context options:[NSDictionary dictionaryWithObjectsAndKeys:@"CIDetectorAccuracyHigh", @"CIDetectorAccuracy", nil]];
        // > 被识别图片中的 人脸数组
        NSArray * features = [detector featuresInImage:coreImage];
        
        if ([features count] >0)
        {
            CIImage * faceImage = [coreImage imageByCroppingToRect:[features[1] bounds]];
            UIImage * face = [UIImage imageWithCGImage:[context createCGImage:faceImage fromRect:faceImage.extent]];
            self.faceImageView.image = face;
            
            [self.findFaceButton setTitle:[NSString stringWithFormat:@"%lu Face(s) Found", (unsigned long)[features count]] forState:UIControlStateNormal];
            self.findFaceButton.enabled = NO;
            self.findFaceButton.alpha = 0.6;
        }
        else
        {
            [self.findFaceButton setTitle:@"No Faces Found"forState:UIControlStateNormal];
            self.findFaceButton.enabled = NO;
            self.findFaceButton.alpha = 0.6;
        }
    
}



@end
