//
//  HDImagePicker.h
//  
//
//  Created by Harshit Daftary on 01/05/13.
//  Copyright (c) 2013 Viteb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^PickerCompletionBlock)(NSDictionary *info, BOOL cancelled);

@interface HDImagePicker : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *objImagePicker;
}

@property (nonatomic,copy) PickerCompletionBlock pickerCompletionBlock;

-(UIImagePickerController*)presentCameraPicker:(PickerCompletionBlock)pBlock;
-(UIImagePickerController*)presentGalleryPicker:(PickerCompletionBlock)pBlock;
+(instancetype)sharedInstance;

@end
