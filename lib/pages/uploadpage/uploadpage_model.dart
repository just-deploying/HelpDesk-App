import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'uploadpage_widget.dart' show UploadpageWidget;
import 'package:flutter/material.dart';

class UploadpageModel extends FlutterFlowModel<UploadpageWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (DeepGram Audio Url)] action in Button widget.
  ApiCallResponse? apiResultoai;
  // Stores action output result for [Gemini - Generate Text] action in Button widget.
  String? audioFormatted;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
