import 'dart:io';

class AdmobBannerId {
  static String getAdmobId(String page, bool isTest) {
    if (isTest) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    } else {
      switch (page) {
        case 'brasil':
          return Platform.isAndroid
              ? 'ca-app-pub-3037761772108066/4667909990'
              : 'ca-app-pub-3037761772108066/4667909990';
        case 'mundo':
          return Platform.isAndroid
              ? 'ca-app-pub-3037761772108066/2881019755'
              : 'ca-app-pub-3037761772108066/2881019755';
        case 'clube':
          return Platform.isAndroid
              ? 'ca-app-pub-3037761772108066/8476127210'
              : 'ca-app-pub-3037761772108066/8476127210';
        case 'letra':
          return Platform.isAndroid
              ? 'ca-app-pub-3037761772108066/2912292428'
              : 'ca-app-pub-3037761772108066/2912292428';
        case 'ranking':
          return Platform.isAndroid
              ? 'ca-app-pub-3037761772108066/7146280394'
              : 'ca-app-pub-3037761772108066/7146280394';
        default:
          return Platform.isAndroid
              ? 'ca-app-pub-3037761772108066/4015235502'
              : 'ca-app-pub-3037761772108066/4015235502';
      }
    }
  }
}
