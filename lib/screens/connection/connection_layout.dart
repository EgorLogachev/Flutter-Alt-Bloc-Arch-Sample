import 'dart:async';

import 'package:flutter/material.dart';

class ConnectionLayout extends StatelessWidget {
  const ConnectionLayout(this._iconData, this._label, {Key key}) : super(key: key);

  final IconData _iconData;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Material(
        child: Stack(
          children: <Widget>[
            Center(
                child: Column(children: <Widget>[
                  _SplashIcon(_iconData),
                  SizedBox(
                    height: 72.0,
                  ),
                  Text(
                    _label,
                    style: Theme
                        .of(context).textTheme.display1.copyWith(color: Colors.black87),
                    textAlign: TextAlign.center,
                  )
                ], mainAxisAlignment: MainAxisAlignment.center)),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.all(24.0),
                onPressed: Navigator.of(context).pop,
                icon: Icon(
                  Icons.close,
                  color: Colors.black87,
                ),
              ),
            )
          ],
        )));
  }
}

class _SplashIcon extends StatefulWidget {
  const _SplashIcon(this._iconData, {Key key}) : super(key: key);

  final IconData _iconData;

  @override
  State<StatefulWidget> createState() => _SplashIconState();
}

class _SplashIconState extends State<_SplashIcon> {
  static const _iconSize = 100.0;
  static const _padding = 48.0;

  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.all(_padding),
        decoration: const ShapeDecoration(shape: CircleBorder(), color: Colors.black),
        child: Builder(builder: (context) {
          return Icon(
            widget._iconData,
            color: Colors.white,
            size: _iconSize,
          );
        }));
  }

  InteractiveInkFeature _createSplash(BuildContext context) {
    final RenderBox referenceBox = context.findRenderObject();
    final Offset position = referenceBox.paintBounds.center;
    return InkRipple(
        controller: Material.of(context),
        referenceBox: referenceBox,
        position: position,
        color: Theme.of(context).splashColor,
        textDirection: Directionality.of(context),
        radius: _iconSize + _padding);
  }

  void _splash(BuildContext context) {
    _createSplash(context).confirm();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashTimer();
    });
    super.initState();
  }

  void _startSplashTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      _splash(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}