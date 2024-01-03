import 'package:flutter/cupertino.dart';
import 'package:ui_package/design/web/footer/footer.dart';

class FooterView extends StatefulWidget {
  final List<Widget> children;
  final Footer footer;
  final int? flex;
  FooterView({super.key, required this.children, required this.footer, this.flex}) {
    if (flex != null) {
      if (flex! > 10 || flex! < 1) {
        throw ArgumentError('Only 1-10 Flex range is allowed');
      }
    }
  }
  @override
  FooterViewState createState() {
    return FooterViewState();
  }
}

class FooterViewState extends State<FooterView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(0.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            widget
                .children, //All children inside Goes here including Columns , Containers, Expanded, ListViews
                
          ),
        ),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: widget.flex == null ? 8 : 10 - widget.flex!,
              child: Container(),
            ),
            Expanded(
                flex: widget.flex == null ? 2 : widget.flex!,
                child: widget.footer)
          ],
        ),
      ),
    ]);
  }
}