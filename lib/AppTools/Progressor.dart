import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';

class Progressor extends StatelessWidget{ 

  final Widget? child;
  final bool? inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  const Progressor({
    Key? key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add( child! );

    if ( inAsyncCall! ){
      final model = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier( dismissible: false,color:color ),
          ),
          const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: chromeYel,
              strokeWidth: 5.0,
            ),
          ),
        ],
      );
      widgetList.add(model);
    }

    return Stack(
      children: widgetList,
    );

  }
}