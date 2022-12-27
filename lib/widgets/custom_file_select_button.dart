import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:amsapp/myutils/logger.dart';
import 'package:amsapp/myutils/styles.dart';

import '../app_localizations.dart';
import '../myutils/app_colors.dart';
import '../myutils/dimens.dart';

class CustomFileSelectButton extends StatefulWidget {
  final String? header;
  final Stream<String>? stream;

  const CustomFileSelectButton({
    Key? key,
    this.header,
    this.stream,
  }) : super(key: key);

  @override
  State<CustomFileSelectButton> createState() => CustomFileSelectButtonState();
}

class CustomFileSelectButtonState extends State<CustomFileSelectButton> {
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
    String fileName = file != null ? basename(file!.path) : "No File Selected";
    String header =
        widget.header ?? AppLocalizations.getString(context, "default_text");
    // String _buttonStatus = file != null
    //     ? AppLocalizations.getString(context, "change_file")
    //     : AppLocalizations.getString(context, "upload_file");
    bool valid = file != null ? true : false;
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                header,
                style: Styles.boldInfoFontStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: Dimens.halfDimens,
            ),
            Visibility(
              visible: valid,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: const CircleAvatar(
                radius: Dimens.normalDimens,
                backgroundColor: AppColors.normal,
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: Dimens.normalDimens * 1.5,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Dimens.normalDimens,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                fileName,
                style: Styles.infoFontStyleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const SizedBox(
            //   height: Dimens.halfDimens,
            // ),
            // Flexible(
            //   child: CustomIndicatorButton(
            //     onPressed: () {},
            //     enableIndicator: true,
            //     text: _buttonStatus,
            //   ),
            // ),
            const SizedBox(
              width: Dimens.normalDimens * 5,
            ),
            GestureDetector(
              onTap: () {
                _showSelectionDialog(context);
              },
              child: const Icon(
                Icons.camera_alt,
                size: Dimens.normalDimens * 3,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: Dimens.minimumDimens,
        ),
        const SizedBox(
          height: Dimens.normalDimens,
        ),
        Visibility(
          visible: file != null,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: Dimens.normalDimens * 14.5,
              height: Dimens.normalDimens * 14.5,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        selectFile();
                      },
                      child: Container(
                        color: AppColors.colorPrimaryLight,
                        width: Dimens.normalDimens * 12,
                        height: Dimens.normalDimens * 12,
                        child: file != null
                            ? Image.file(file!,
                                width: Dimens.normalDimens * 12,
                                height: Dimens.normalDimens * 12,
                                fit: BoxFit.fitHeight)
                            : const SizedBox(
                                width: Dimens.normalDimens * 12,
                                height: Dimens.normalDimens * 12,
                                child: Icon(Icons.add),
                              ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: file != null ? true : false,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            filePath = "";
                            file = null;
                            valid = false;
                          });
                        },
                        child: const CircleAvatar(
                          radius: Dimens.normalDimens * 1.5,
                          backgroundColor: AppColors.normal,
                          child: Icon(
                            Icons.close,
                            size: Dimens.normalDimens * 2,
                            color: AppColors.colorPrimaryLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!_isValid)
          Text(
            _errorText,
            style: Styles.errorTextStyle,
          ),
      ],
    );
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png'],
    );

    if (result != null) {
      String? path = result.files.single.path;

      setState(() {
        if (File(path!).lengthSync() < 2097152) {
          filePath = path;
          file = File(path);
          // ext = extension(file!.path);
          // if (ext == ".pdf") {
          //   pdfImage(file!.path);
          // }
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

  // pdfImage(String filePath) async {
  //   try {
  //     final document = await PdfDocument.openAsset(filePath);
  //     final page = await document.getPage(1);
  //     final pageImage = await page.render(
  //         width: Dimens.normalDimens.round() * 12,
  //         height: Dimens.normalDimens.round() * 12);
  //     await page.close();
  //     setState(() {
  //       pdfImg = MemoryImage(pageImage!.bytes);
  //     });
  //   } on PlatformException catch (error) {
  //     print(error);
  //   }
  // }

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

  _showSelectionDialog(BuildContext context) {
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
                  height: Dimens.normalDimens * 2,
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
