import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/helpers/admob_banner_id.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddAdmobBanner extends StatefulWidget {
  final bool isTest;
  final String page;
  const AddAdmobBanner({
    super.key,
    required this.isTest,
    required this.page,
  });

  @override
  State<AddAdmobBanner> createState() => _AddAdmobBannerState();
}

class _AddAdmobBannerState extends State<AddAdmobBanner> {
  BannerAd? bannerAd;
  bool isBannerAdLoaded = false;
  late final String adUnitId;
  @override
  void initState() {
    super.initState();
    adUnitId = AdmobBannerId.getAdmobId(widget.page, widget.isTest);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadBannerAd();
  }

  Future<void> loadBannerAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            bannerAd = ad as BannerAd;
            isBannerAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          isBannerAdLoaded = false;
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    );
    return bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdLoaded
        ? bannerAd != null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: SizedBox(
                    width: bannerAd!.size.width.toDouble(),
                    height: bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd!),
                  ),
                ),
              )
            : Container()
        : Container();
  }
}
