import 'dart:io';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'log_utility.dart';

abstract class ImageUtilityService {
  const ImageUtilityService();
  Future<File?> pickImageFromGallery(
      {bool cropImage = false,
      CameraDevice preferredCameraDevice = CameraDevice.rear});

  Future<File?> pickImageFromCamera(
      {bool cropImage = false,
      CameraDevice preferredCameraDevice = CameraDevice.rear});

  Future<File?> pickImage({bool cropImage = false});
}

class ImageUtilityServiceImpl implements ImageUtilityService {
  const ImageUtilityServiceImpl();
  static int imageQuality = 45;
  @override
  Future<File?> pickImageFromGallery(
      {bool cropImage = false,
      CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );

    if (cropImage && pickedFile != null) {
      return cropSelectedImage(pickedFile.path);
    }

    return pickedFile != null ? File(pickedFile.path) : null;
  }

  @override
  Future<File?> pickImageFromCamera(
      {bool cropImage = false,
      CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    LogUtility.info('Came $preferredCameraDevice');
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );

    if (cropImage && pickedFile != null) {
      return cropSelectedImage(pickedFile.path);
    }

    return pickedFile != null ? File(pickedFile.path) : null;
  }

  @override
  Future<File?> pickImage({bool cropImage = false}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
        'heif',
        'webp',
        'tiff',
        'psd',
        'ai',
      ],
    );

    if (result == null || result.files.isEmpty) return null;

    if (cropImage) {
      final croppedFile = await cropSelectedImage(result.files.first.path!);
      return File(croppedFile!.path);
    }

    return File(result.files.first.path!);
  }

  Future<File?> cropSelectedImage(String filePath) async {
    final imageCropper = ImageCropper();
    final file = await imageCropper.cropImage(
      uiSettings: [
        AndroidUiSettings(
          // statusBarColor: AppColors.primary,
          cropFrameColor: AppColors.buttonBackground,
          backgroundColor: AppColors.buttonBackground,
          cropGridColor: AppColors.buttonBackground,
          lockAspectRatio: true,
          toolbarColor: AppColors.buttonBackground,
          toolbarWidgetColor: Constants.WHITE,
          toolbarTitle: 'Crop Selected Picture',
          initAspectRatio: CropAspectRatioPreset.square,
          activeControlsWidgetColor: AppColors.buttonBackground,
        ),
        IOSUiSettings(
          aspectRatioLockEnabled: true,
          cancelButtonTitle: 'Cancel',
          doneButtonTitle: 'Done',
          hidesNavigationBar: true,
          title: 'Crop Selected Picture',
        )
      ],
      sourcePath: filePath,
      maxHeight: 800,
      maxWidth: 800,
      compressQuality: 100,
    );
    if (file == null) {
      return null;
    } else {
      return File(file.path);
    }
  }
}
