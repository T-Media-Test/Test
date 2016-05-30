//
//  HDImagePicker.m
//
//
//  Created by Harshit Daftary on 01/05/13.
//  Copyright (c) 2013 Viteb. All rights reserved.
//

#import "HDImagePicker.h"

@implementation HDImagePicker

+(instancetype)sharedInstance
{
    static HDImagePicker *objManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objManager = [[HDImagePicker alloc] init];
        [objManager initializeOnce];
    });
    return objManager;
}

-(void)initializeOnce
{
    objImagePicker = [[UIImagePickerController alloc] init];
    objImagePicker.delegate = self;
    objImagePicker.allowsEditing = YES;
}

-(UIImagePickerController*)presentCameraPicker:(PickerCompletionBlock)pBlock
{
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera])
    {
        objImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

        if (pBlock)
            _pickerCompletionBlock = pBlock;
        
        return objImagePicker;
    }
    return nil;
}

-(UIImagePickerController*)presentGalleryPicker:(PickerCompletionBlock)pBlock
{
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        objImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if (pBlock)
            _pickerCompletionBlock = pBlock;
        
        return objImagePicker;
    }
    return nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (_pickerCompletionBlock)
        _pickerCompletionBlock(info,NO);
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (_pickerCompletionBlock)
        _pickerCompletionBlock(nil,YES);
}

@end