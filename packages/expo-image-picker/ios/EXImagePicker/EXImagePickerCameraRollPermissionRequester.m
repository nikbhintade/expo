// Copyright 2017-present 650 Industries. All rights reserved.

#import <EXImagePicker/EXImagePickerCameraRollPermissionRequester.h>

#import <Photos/Photos.h>

@implementation EXImagePickerCameraRollPermissionRequester

+ (NSString *)permissionType
{
  return @"cameraRoll";
}

- (NSDictionary *)getPermissions
{
  UMPermissionStatus status;
  NSString *scope;
  PHAuthorizationStatus permissions = [PHPhotoLibrary authorizationStatus];
  switch (permissions) {
     case PHAuthorizationStatusAuthorized:
       status = UMPermissionStatusGranted;
       scope = @"all";
       break;
#ifdef __IPHONE_14_0
     case PHAuthorizationStatusLimited:
       status = UMPermissionStatusGranted;
       scope = @"limited";
       break;
#endif
     case PHAuthorizationStatusDenied:
     case PHAuthorizationStatusRestricted:
       status = UMPermissionStatusDenied;
       scope = @"none";
       break;
     case PHAuthorizationStatusNotDetermined:
       status = UMPermissionStatusUndetermined;
       scope = @"none";
       break;
  }
  return @{
    @"status": @(status),
    @"accessPrivileges": scope,
    @"granted": @(status == UMPermissionStatusGranted)
  };
}

- (void)requestPermissionsWithResolver:(UMPromiseResolveBlock)resolve rejecter:(UMPromiseRejectBlock)reject
{
  UM_WEAKIFY(self)
  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    UM_STRONGIFY(self)
    resolve([self getPermissions]);
  }];
}

@end
