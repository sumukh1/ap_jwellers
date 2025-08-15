import 'dart:io';
import 'package:myapp/core/services/image_uitility.dart';
import 'package:myapp/core/widget/file_viewer.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../static/constants.dart';

class AppFilePicker extends StatelessWidget {
  const AppFilePicker({
    super.key,
    this.multiFile = false,
    this.label,
    required this.onChange,
    this.preferredCameraDevice = CameraDevice.rear,
  });
  final bool multiFile;
  final String? label;
  final Function(List<String>) onChange;
  final CameraDevice preferredCameraDevice;
  final ImageUtilityServiceImpl imagePicker = const ImageUtilityServiceImpl();

  @override
  Widget build(BuildContext context) {
    Future<void> showFilePickerOptions() async {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Constants.buttonText),
                title: Text("Take a Photo"),
                onTap: () async {
                  final file = await imagePicker.pickImageFromCamera(
                    preferredCameraDevice: preferredCameraDevice,
                  );
                  if (file != null) onChange([file.path]);
                  context.pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Constants.buttonText),
                title: Text("Choose from Gallery"),
                onTap: () async {
                  final file = await imagePicker.pickImageFromGallery(
                    preferredCameraDevice: preferredCameraDevice,
                  );
                  if (file != null) onChange([file.path]);
                  context.pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file, color: Constants.buttonText),
                title: Text("Select Files"),
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: multiFile,
                  );
                  if (result != null) {
                    final files =
                        result.paths.map((path) => File(path!)).toList();
                    List<String> uploadedFiles = [];
                    for (var file in files) {
                      uploadedFiles = [...uploadedFiles, file.path];
                    }
                    onChange(uploadedFiles);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Button(onTap: showFilePickerOptions, label: label ?? "Attach Files");
  }
}

bool isImageFile(String path) {
  final extensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
  return extensions.any((ext) => path.toLowerCase().endsWith(ext));
}

class UniversalImageView extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const UniversalImageView({
    Key? key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        imageView(context, path);
      },
      child: Image(
        image: imageProvider(path: path),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.broken_image, color: Colors.red),
          );
        },
      ),
    );
  }
}
