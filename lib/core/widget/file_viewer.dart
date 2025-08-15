import 'dart:io';

import 'package:myapp/core/widget/file_picker.dart';
import 'package:myapp/core/widget/pdfviewer.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter

void imageView(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (context) => ImageModal(
      imageUrl: url, // Replace with your image URL
    ),
  );
}

void imagesView(BuildContext context, List<String> imageUrls) {
  showDialog(
    context: context,
    builder: (context) => ImageListModal(
      imageUrls: imageUrls,
    ),
  );
}

class ImageModal extends StatelessWidget {
  final String imageUrl;

  const ImageModal({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Blurred background
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Constants.BLACK.withOpacity(0.6), // Dim the background
              ),
            ),
          ),
          // Centered image
          Center(
            child: GestureDetector(
              onDoubleTap: () => Navigator.pop(context), // Close on tap
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Image(
                  image: imageProvider(path: imageUrl),
                  fit: BoxFit.contain, // Ensures the image scales properly
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageListModal extends StatefulWidget {
  final List<String> imageUrls;

  const ImageListModal({Key? key, required this.imageUrls}) : super(key: key);

  @override
  State<ImageListModal> createState() => _ImageListModalState();
}

class _ImageListModalState extends State<ImageListModal> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Constants.BLACK.withOpacity(0.6), // Dim the background
            ),
          ),
          // Swipable Image Viewer
          Center(
            child: PageView.builder(
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pop(context), // Close on tap
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.contain, // Ensure proper scaling
                  ),
                );
              },
            ),
          ),
          // Page Indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imageUrls.map((url) {
                  int index = widget.imageUrls.indexOf(url);
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Constants.WHITE
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FileViewer extends StatelessWidget {
  const FileViewer(
      {super.key,
      required this.filePaths,
      this.showDelete = false,
      this.wrapDesign = false,
      this.onDelete});
  final List<String> filePaths;
  final bool showDelete;
  final void Function(int)? onDelete;
  final bool wrapDesign;
  @override
  Widget build(BuildContext context) {
    if (filePaths.isNotEmpty && wrapDesign == false) {
      return ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: filePaths.length,
        itemBuilder: (context, index) {
          if (filePaths[index].isEmpty) return SizedBox();

          return Padding(
            padding: Styles.edgeV5,
            child: Container(
                padding: Styles.edgeAll5,
                color: Constants.WHITE,
                child: Row(
                  children: [
                    Expanded(
                      child: isImageFile(filePaths[index])
                          ? UniversalImageView(
                              path: filePaths[index],
                              height: 150,
                            )
                          : GestureDetector(
                              onTap: () {
                                if (filePaths[index].contains('pdf'))
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          AppPdfViewer(url: filePaths[index])));
                              },
                              child: Icon(Icons.insert_drive_file,
                                  size: 40, color: Constants.PURPLE),
                            ),
                    ),
                    if (showDelete)
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          if (onDelete != null) {
                            onDelete!(index);
                          }
                        },
                      ),
                  ],
                )),
          );
        },
      );
    } else if (filePaths.isNotEmpty && wrapDesign == true) {
      return Wrap(
        children: [
          ...filePaths.asMap().entries.map((entry) {
            int index = entry.key;
            final path = entry.value;
            if (path.isEmpty) return Container();
            String name = path.split('/').last;
            return Container(
              margin: EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width * 0.49,
              height: 100,
              child: GestureDetector(
                onTap: () {
                  if (path.contains('pdf')) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AppPdfViewer(url: filePaths[index])));
                  } else {
                    imageView(context, path);
                  }
                },
                child: Card(
                  color: Constants.WHITE,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          path.contains('pdf') ? Icons.file_copy : Icons.image,
                          size: 40,
                          color: Constants.PURPLE,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.PURPLE,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              if (showDelete)
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.grey),
                                  onPressed: () {
                                    if (onDelete != null) {
                                      onDelete!(index);
                                    }
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      );
    } else {
      return Center(
        child: Text("No files", style: TextStyle(color: Colors.grey)),
      );
    }
  }
}

ImageProvider imageProvider({required String path}) {
  bool _isUrl = path.startsWith('http://') || path.startsWith('https://');
  bool _isAsset = !path.startsWith('/') && !path.contains('://');
  ImageProvider imageProvider;
  if (_isUrl) {
    imageProvider = NetworkImage(path);
  } else if (_isAsset) {
    imageProvider = AssetImage(path);
  } else {
    imageProvider = FileImage(File(path));
  }
  return imageProvider;
}
