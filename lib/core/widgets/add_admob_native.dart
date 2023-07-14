import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddAdmob extends StatefulWidget {
  final int index;
  const AddAdmob({super.key, required this.index});

  @override
  State<AddAdmob> createState() => _AddAdmobState();
}

class _AddAdmobState extends State<AddAdmob> {
  NativeAd? nativeAd;
  bool isNativeAdLoaded = false;
  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3037761772108066/2727041318' // ID admob real
      //'ca-app-pub-3940256099942544/2247696110' // iD admob de teste
      : 'ca-app-pub-3037761772108066/2727041318';
  @override
  void initState() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            if (!isNativeAdLoaded) {
              setState(() {
                isNativeAdLoaded = true;
              });
            }
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
            setState(() {
              isNativeAdLoaded = false;
            });
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.small))
      ..load();
    super.initState();
  }

  @override
  void dispose() {
    nativeAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isNativeAdLoaded
        ? (widget.index == 6)
            ? ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 320, // minimum recommended width
                  minHeight: 90, // minimum recommended height
                  maxWidth: 400,
                  maxHeight: 90,
                ),
                child: AdWidget(ad: nativeAd!),
              )
            : Container()
        : Container();
  }
}
