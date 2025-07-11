// import 'package:active_ecommerce_cms_demo_app/custom/toast_component.dart';
// import 'package:active_ecommerce_cms_demo_app/custom/useful_elements.dart';
// import 'package:active_ecommerce_cms_demo_app/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_cms_demo_app/helpers/shimmer_helper.dart';
// import 'package:active_ecommerce_cms_demo_app/my_theme.dart';
// import 'package:active_ecommerce_cms_demo_app/providers/locale_provider.dart';
// import 'package:active_ecommerce_cms_demo_app/repositories/coupon_repository.dart';
// import 'package:active_ecommerce_cms_demo_app/repositories/language_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class ChangeLanguage extends StatefulWidget {
//   const ChangeLanguage({super.key});

//   @override
//   _ChangeLanguageState createState() => _ChangeLanguageState();
// }

// class _ChangeLanguageState extends State<ChangeLanguage> {
//   var _selected_index = 0;
//   final ScrollController _mainScrollController = ScrollController();
//   final _list = [];
//   bool _isInitial = true;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     fetchList();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _mainScrollController.dispose();
//   }

//   fetchList() async {
//     var languageListResponse = await LanguageRepository().getLanguageList();
//     _list.addAll(languageListResponse.languages!);

//     var idx = 0;
//     if (_list.isNotEmpty) {
//       for (var lang in _list) {
//         if (lang.code == app_language.$) {
//           setState(() {
//             _selected_index = idx;
//           });
//         }
//         idx++;
//       }
//     }
//     _isInitial = false;
//     setState(() {});
//   }

//   reset() {
//     _list.clear();
//     _isInitial = true;
//     _selected_index = 0;
//     setState(() {});
//   }

//   Future<void> _onRefresh() async {
//     reset();
//     fetchList();
//   }

//   onPopped(value) {
//     reset();
//     fetchList();
//   }

//   onCouponRemove() async {
//     var couponRemoveResponse =
//         await CouponRepository().getCouponRemoveResponse();

//     if (couponRemoveResponse.result == false) {
//       ToastComponent.showDialog(
//         couponRemoveResponse.message,
//       );
//       return;
//     }
//   }

//   onLanguageItemTap(index) {
//     if (index != _selected_index) {
//       setState(() {
//         _selected_index = index;
//       });

//       // if(Locale().)

//       app_language.$ = _list[_selected_index].code;
//       app_language.save();
//       app_mobile_language.$ = _list[_selected_index].mobile_app_code;
//       app_mobile_language.save();
//       app_language_rtl.$ = _list[_selected_index].rtl;
//       app_language_rtl.save();

//       // var local_provider = new LocaleProvider();
//       // local_provider.setLocale(_list[_selected_index].code);
//       Provider.of<LocaleProvider>(context, listen: false)
//           .setLocale(_list[_selected_index].mobile_app_code);
//       context.go('/');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection:
//           app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//           backgroundColor: MyTheme.mainColor,
//           appBar: buildAppBar(context),
//           body: Stack(
//             children: [
//               RefreshIndicator(
//                 color: MyTheme.accent_color,
//                 backgroundColor: Colors.white,
//                 onRefresh: _onRefresh,
//                 displacement: 0,
//                 child: CustomScrollView(
//                   controller: _mainScrollController,
//                   physics: const BouncingScrollPhysics(
//                       parent: AlwaysScrollableScrollPhysics()),
//                   slivers: [
//                     SliverList(
//                       delegate: SliverChildListDelegate([
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: buildLanguageMethodList(),
//                         ),
//                       ]),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: MyTheme.mainColor,
//       scrolledUnderElevation: 0.0,
//       centerTitle: false,
//       leading: Builder(
//         builder: (context) => IconButton(
//           padding: EdgeInsets.zero,
//           icon: UsefulElements.backButton(context),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       title: Text(
//         "${AppLocalizations.of(context)!.change_language_ucf} (${app_language.$}) - (${app_mobile_language.$})",
//         style: TextStyle(
//             fontSize: 16,
//             color: MyTheme.dark_font_grey,
//             fontWeight: FontWeight.bold),
//       ),
//       elevation: 0.0,
//       titleSpacing: 0,
//     );
//   }

//   buildLanguageMethodList() {
//     if (_isInitial && _list.isEmpty) {
//       return SingleChildScrollView(
//           child: ShimmerHelper()
//               .buildListShimmer(item_count: 5, item_height: 100.0));
//     } else if (_list.isNotEmpty) {
//       return SingleChildScrollView(
//         child: ListView.separated(
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               height: 14,
//             );
//           },
//           itemCount: _list.length,
//           scrollDirection: Axis.vertical,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return buildPaymentMethodItemCard(index);
//           },
//         ),
//       );
//     } else if (!_isInitial && _list.isEmpty) {
//       return SizedBox(
//           height: 100,
//           child: Center(
//               child: Text(
//             AppLocalizations.of(context)!.no_language_is_added,
//             style: TextStyle(color: MyTheme.font_grey),
//           )));
//     }
//   }

//   GestureDetector buildPaymentMethodItemCard(index) {
//     return GestureDetector(
//       onTap: () {
//         onLanguageItemTap(index);
//       },
//       child: Stack(
//         children: [
//           AnimatedContainer(
//             duration: Duration(milliseconds: 400),
//             decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(6.0))
//                 .copyWith(
//                     border: Border.all(
//                         color: _selected_index == index
//                             ? MyTheme.accent_color
//                             : MyTheme.light_grey,
//                         width: _selected_index == index ? 1.0 : 0.0)),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child:
//                               /*Image.asset(
//                           _list[index].image,
//                           fit: BoxFit.fitWidth,
//                         ),*/
//                               FadeInImage.assetNetwork(
//                             placeholder: 'assets/placeholder.png',
//                             image: _list[index].image,
//                             fit: BoxFit.fitWidth,
//                           ))),
//                   SizedBox(
//                     width: 150,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             "${_list[index].name} - ${_list[index].code} - ${_list[index].mobile_app_code}",
//                             textAlign: TextAlign.left,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                             style: TextStyle(
//                                 color: Color(0xff3E4447),
//                                 fontSize: 12,
//                                 height: 1.6,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//           ),
//           app_language_rtl.$!
//               ? Positioned(
//                   left: 16,
//                   top: 16,
//                   child: buildCheckContainer(_selected_index == index),
//                 )
//               : Positioned(
//                   right: 16,
//                   top: 16,
//                   child: buildCheckContainer(_selected_index == index),
//                 )
//         ],
//       ),
//     );
//   }

//   Container buildCheckContainer(bool check) {
//     return check
//         ? Container(
//             height: 16,
//             width: 16,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.0), color: Colors.green),
//             child: Padding(
//               padding: const EdgeInsets.all(3),
//               child: Icon(Icons.check, color: Colors.white, size: 10),
//             ),
//           )
//         : Container();
//   }
// }



import 'package:active_ecommerce_cms_demo_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_cms_demo_app/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_cms_demo_app/my_theme.dart';
import 'package:active_ecommerce_cms_demo_app/providers/locale_provider.dart';

import 'package:active_ecommerce_cms_demo_app/repositories/language_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  var _selected_index = 0;
  final ScrollController _mainScrollController = ScrollController();
  final List _list = [];
  bool _isInitial = true;

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  fetchList() async {
    var languageListResponse = await LanguageRepository().getLanguageList();
    _list.addAll(languageListResponse.languages!);

    var idx = 0;
    if (_list.isNotEmpty) {
      for (var lang in _list) {
        if (lang.code == app_language.$) {
          setState(() {
            _selected_index = idx;
          });
        }
        idx++;
      }
    }
    _isInitial = false;
    setState(() {});
  }

  reset() {
    _list.clear();
    _isInitial = true;
    _selected_index = 0;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchList();
  }

  onPopped(value) {
    reset();
    fetchList();
  }

onLanguageItemTap(index) {
  String selectedCode = _list[index].mobile_app_code;

  // Check if the selected language exists in supported locales
  bool isLanguageSupported = AppLocalizations.supportedLocales
      .any((locale) => locale.languageCode == selectedCode);

  if (!isLanguageSupported) {
    _showLanguageNotAvailableDialog();
    return;
  }

  if (index != _selected_index) {
    setState(() {
      _selected_index = index;
    });

    // Save the selected language details
    app_language.$ = _list[_selected_index].code;
    app_language.save();
    app_mobile_language.$ = _list[_selected_index].mobile_app_code;
    app_mobile_language.save();
    app_language_rtl.$ = _list[_selected_index].rtl;
    app_language_rtl.save();

    // Set the new locale
    Provider.of<LocaleProvider>(context, listen: false)
        .setLocale(_list[_selected_index].mobile_app_code);

    // Trigger GoRouter navigation to reload the app and apply changes
    GoRouter.of(context).goNamed('Home'); // Change 'Home' to your main route
  }
}


  void _showLanguageNotAvailableDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Language Not Setup"),
        content: Text("This language is not yet available in the app."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              onRefresh: _onRefresh,
              displacement: 0,
              child: CustomScrollView(
                controller: _mainScrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: buildLanguageMethodList(),
                      ),]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: Builder(
        builder: (context) => IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "${AppLocalizations.of(context)!.change_language_ucf} (${app_language.$}) - (${app_mobile_language.$})",
        style: TextStyle(
            fontSize: 16,
            color: MyTheme.dark_grey,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildLanguageMethodList() {
    if (_isInitial && _list.isEmpty) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_list.isNotEmpty) {
      return SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 14);
          },
          itemCount: _list.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildPaymentMethodItemCard(index);
          },
        ),
      );
    } else {
      return SizedBox(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.no_language_is_added,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  GestureDetector buildPaymentMethodItemCard(index) {
    return GestureDetector(
      onTap: () {
        onLanguageItemTap(index);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            decoration: MDecoration.decoration1().copyWith(
                border: Border.all(
                    color: _selected_index == index
                        ? MyTheme.accent_color
                        : MyTheme.light_grey,
                    width: _selected_index == index ? 1.0 : 0.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: _list[index].image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${_list[index].name} - ${_list[index].code} - ${_list[index].mobile_app_code}",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: MyTheme.font_grey,
                            fontSize: 14,
                            height: 1.6,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ]), 
          ),
        ],
      ),
    );
  }
  
}
class MDecoration {
  static BoxDecoration decoration1(
      {double radius = 6.0, bool showShadow = true}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: MyTheme.white,
      boxShadow: [
        showShadow
            ? BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 0.0,
                offset:
                    const Offset(0.0, 10.0), // shadow direction: bottom right
              )
            : const BoxShadow()
      ],
    );
  }
}