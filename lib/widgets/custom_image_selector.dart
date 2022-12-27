import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:amsapp/myutils/preference.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amsapp/myutils/styles.dart';
import '../myutils/app_colors.dart';
import '../myutils/dimens.dart';
import '../myutils/logger.dart';

class CustomImageSelector extends StatefulWidget {
  final String fileId;
  final Stream<String>? stream;

  const CustomImageSelector({
    Key? key,
    this.stream,
    required this.fileId,
  }) : super(key: key);

  @override
  State<CustomImageSelector> createState() => CustomImageSelectorState();
}

class CustomImageSelectorState extends State<CustomImageSelector> {
  String filePath = "";
  File? file;
  final ImagePicker _picker = ImagePicker();
  String _errorText = "";
  bool _isValid = true;
  bool valid = false;

  void updateValidate(String error) {
    setState(() {
      _errorText = error;
      _isValid = _errorText.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.stream?.listen((errorString) {
      updateValidate(errorString);
    });
  }

  @override
  Widget build(BuildContext context) {
    // String _buttonStatus = file != null
    //     ? AppLocalizations.getString(context, "change_file")
    //     : AppLocalizations.getString(context, "upload_file");
    return Column(
      children: [
        SizedBox(
          height: Dimens.normalDimens * 11,
          width: Dimens.normalDimens * 11,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: Dimens.normalDimens * 5,
                  child: file != null
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimens.normalDimens * 5),
                          child: Image.file(
                            file!,
                            // width: Dimens.normalDimens * 12,
                            // height: Dimens.normalDimens * 12,
                            fit: BoxFit.fill,
                          ),
                        )
                      : const Icon(Icons.camera_alt),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: Dimens.normalDimens * 3,
                  child: FloatingActionButton(
                    heroTag: "btnEdit",
                    key: null,
                    mini: true,
                    backgroundColor: AppColors.white,
                    child: const Icon(
                      Icons.edit,
                      size: Dimens.normalDimens * 1.5,
                      color: AppColors.colorPrimaryLight,
                    ),
                    onPressed: () => _showSelectionDialog(context),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: Dimens.normalDimens,
        ),
        if (!_isValid)
          Text(
            _errorText,
            style: Styles.errorTextStyle,
          ),
      ],
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png'],
    );

    if (result != null) {
      final path = result.files.single.path;

      setState(() {
        if (File(path!).lengthSync() < 2097152) {
          file = File(path);
          valid = true;
          updateValidate("");
        } else {
          updateValidate("File Size Limit Exceeded");
        }
      });
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  Future<void> cameraImage() async {
    // ImageSource source = type == ImageSourceType.camera
    //     ? ImageSource.camera
    //     : ImageSource.gallery;
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image != null) {
      setState(() {
        if (File(image.path).lengthSync() < 2097152) {
          Preference.setString(widget.fileId, image.path);
          filePath = image.path;
          Logger.printLog("filePath:${image.path}");
          Logger.printLog("basename(filePath):${basename(filePath)}");
          file = File(image.path);
          valid = true;
          updateValidate("");
        } else {
          updateValidate("File Size Limit Exceeded");
        }
      });
    }
  }

  Future<void> galleryImage() async {
    // ImageSource source = type == ImageSourceType.camera
    //     ? ImageSource.camera
    //     : ImageSource.gallery;
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        if (File(image.path).lengthSync() < 2097152) {
          Preference.setString(widget.fileId, image.path);
          filePath = image.path;
          Logger.printLog("filePath:${image.path}");
          Logger.printLog("basename(filePath):${basename(filePath)}");
          file = File(image.path);
          // ext = extension(image.path);
          // pdfImg = MemoryImage(Uint8List(0));
          valid = true;
          updateValidate("");
        } else {
          updateValidate("File Size Limit Exceeded");
        }
      });
    }
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: (context),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Attach a Photo"),
          contentPadding: const EdgeInsets.fromLTRB(Dimens.normalDimens * 3, 0,
              Dimens.normalDimens * 3, Dimens.normalDimens * 2.5),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: Dimens.normalDimens,
                ),
                GestureDetector(
                  child: const Text("Upload a Photo"),
                  onTap: () {
                    galleryImage();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: Dimens.normalDimens * 1.5,
                ),
                GestureDetector(
                  child: const Text("Take a Photo"),
                  onTap: () {
                    cameraImage();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
