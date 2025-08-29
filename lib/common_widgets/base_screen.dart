import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  final Widget screen;
  final Future<bool> Function()? onBackPressed;

  const BaseScreen({required this.screen, this.onBackPressed, super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (widget.onBackPressed != null) {
          widget.onBackPressed!() ;
        } else {
          Navigator.of(context).maybePop();
        }
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: widget.screen,
            ),
          ),
        ),
      ),
    );
  }
}
