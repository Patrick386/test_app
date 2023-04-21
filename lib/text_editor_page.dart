
import 'package:flutter/material.dart';
import 'package:untitled1/platform_selector.dart';

import 'constants.dart';

class TextEditorPage extends StatelessWidget {
   TextEditorPage({Key? key, required this.onChangedPlatform}) : super(key: key);
  static const String route = 'text-editor';
  static const String title = 'Text Editor';
  static const String subtitle =
      'The copy button copies but also shows a menu.';
  static const String url = '$kCodeUrl/text_editor_page.dart';

  final PlatformCallback onChangedPlatform;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Column(
            children: [
              TextButton(onPressed: (){

              }, child: Text('TextField Test')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: EditableText(
                    controller: _controller,
                    maxLines: null,

                    style: TextStyle(fontSize: 18.0),
                    cursorColor: Colors.blue,
                    backgroundCursorColor: Colors.amber,
                    keyboardType: TextInputType.multiline,
                    focusNode: _focusNode,
                    selectionControls: MyMaterialTextSelectionControls(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: TextField(
                    controller: _controller,
                    maxLines: null,


                    style: TextStyle(fontSize: 18.0),
                    cursorColor: Colors.blue,

                    keyboardType: TextInputType.multiline,
                    focusNode: _focusNode,

                    selectionControls: MyMaterialTextSelectionControls(),
                    // contextMenuBuilder: (context, editableTextState) {
                    //   return AdaptiveTextSelectionToolbar.buttonItems(
                    //     anchors: editableTextState.contextMenuAnchors,
                    //     buttonItems: <ContextMenuButtonItem>[
                    //       ContextMenuButtonItem(
                    //         onPressed: () {
                    //           editableTextState.cutSelection(SelectionChangedCause.toolbar);
                    //         },
                    //         type: ContextMenuButtonType.cut,
                    //       ),
                    //     ],
                    //   );
                    // },
                  ),
                ),
              ),
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


///https://docs.flutter.dev/release/breaking-changes/context-menus
class MyMaterialTextSelectionControls extends MaterialTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 10.0;
  static const double _kToolbarContentDistance = 8.0;

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier? clipboardStatus,
      Offset? lastSecondaryTapDownPosition,
      ) {
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
    endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          startTextSelectionPoint.point.dy -
          textLineHeight -
          _kToolbarContentDistance,
    );
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );
    final value = delegate.textEditingValue;

    final TextStyle? style = delegate.textEditingValue.selection.isValid
        ? TextStyle(
        color: delegate.textEditingValue.selection.isCollapsed
            ? Colors.black
            : Colors.blue,
        backgroundColor: Colors.yellow)
        : null;

    return MyTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleCustomButton: () {
        print(value.selection.textInside(value.text));
        delegate.hideToolbar();
      }, handleColorChangeButton: () {
       /// 컬러변경
      // get selected text and its style
      final TextEditingValue value = delegate.textEditingValue;
      final TextSelection selection = value.selection;
      final TextStyle currentStyle = style ?? TextStyle();
      final String selectedText = selection.textInside(value.text);

      // calculate the new style
      final TextStyle newStyle = currentStyle.copyWith(
        color: Colors.green,
      );

      // create the new value with the updated style
      final TextEditingValue newValue = TextEditingValue(
        text: value.text.replaceRange(
          selection.start,
          selection.end,
          selectedText,
        ),
        selection: TextSelection.collapsed(
          offset: selection.start + selectedText.length,
          affinity: selection.affinity,
        ),
        composing: TextRange.empty,
      );

      // apply the new value and style
      //delegate.textEditingValue = newValue;

      delegate.userUpdateTextEditingValue(newValue, SelectionChangedCause.tap);
      // delegate.u(
      //   selection,
      //   newValue,
      //   SelectionChangedCause.toolbar,
      // );
      delegate.hideToolbar();
    },
    );
  }
}

class MyTextSelectionToolbar extends StatelessWidget {
  const MyTextSelectionToolbar({
    Key? key,
    required this.anchorAbove,
    required this.anchorBelow,
    required this.clipboardStatus,
    required this.handleCustomButton, required this.handleColorChangeButton,
  }) : super(key: key);
  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier? clipboardStatus;
  final VoidCallback? handleCustomButton;
  final VoidCallback? handleColorChangeButton;
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    /// 버튼 데이터
    final List<_TextSelectionToolbarItemData> items =
    <_TextSelectionToolbarItemData>[
      _TextSelectionToolbarItemData(
        onPressed: handleColorChangeButton ?? () {},
        label: 'Color change',
      ),
      _TextSelectionToolbarItemData(
        onPressed: handleCustomButton ?? () {},
        label: 'Custom button',
      ),
    ];
    int childIndex = 0;
    return TextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      toolbarBuilder: (BuildContext context, Widget child) =>
          Container(color: Colors.pink, child: child),
      children: items
          .map((_TextSelectionToolbarItemData itemData) =>
          TextSelectionToolbarTextButton(
            padding: TextSelectionToolbarTextButton.getPadding(
                childIndex++, items.length),
            onPressed: itemData.onPressed,
            child: Text(itemData.label),
          ))
          .toList(),
    );
  }
}

class _TextSelectionToolbarItemData {
  const _TextSelectionToolbarItemData({
    required this.label,
    required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;
}
