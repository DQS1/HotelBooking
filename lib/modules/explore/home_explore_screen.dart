import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_booking/models/hotel_list_data.dart';
import 'package:hotel_booking/modules/explore/home_explore_slider_view.dart';
import 'package:hotel_booking/modules/explore/hotel_list_view.dart';
import 'package:hotel_booking/modules/explore/popular_list_view.dart';
import 'package:hotel_booking/modules/explore/title_view.dart';
import 'package:hotel_booking/providers/theme_provider.dart';
import 'package:hotel_booking/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../language/appLocalizations.dart';
import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/bottom_top_move_animation_view.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_card.dart';
import '../../widgets/common_search_bar.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;
  const HomeExploreScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  State<HomeExploreScreen> createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen>
 with TickerProviderStateMixin {
  var hotelList = HotelListData.hotelList;
  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHieght = 0.0;

  @override
  void initState(){
    _animationController =
        AnimationController(vsync: this,duration: Duration(milliseconds: 0));
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller
    ..addListener(() {
      if(mounted){
        if(controller.offset <0 ){
          _animationController.animateTo(0.0);
        } else if(controller.offset > 0.0 &&
        controller.offset < sliderImageHieght) {
          if(controller.offset < ((sliderImageHieght/1.5))){
            _animationController
            .animateTo((controller.offset / sliderImageHieght));
          } else {
            _animationController
            .animateTo((sliderImageHieght / 1.5)/sliderImageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Consumer<ThemeProvider>(
        builder: (context,value, child) => Stack(
          children: [
            Container(
              color: AppTheme.scaffoldBackgroundColor,
              child: ListView.builder(
                controller: controller,
                  itemCount: 4,
                  padding: EdgeInsets.only(
                    top: sliderImageHieght + 32, bottom: 16
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index) {
                  var count = 4;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  if (index == 0) {
                    return TitleView(
                      titleTxt:
                      AppLocalizations(context).of("popular_destination"),
                      subTxt: '',
                      animation: animation,
                      animationController: widget.animationController,
                      click: () {},
                    );
                  }else if(index == 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      //Popular Destinations animation view
                      child: PopularListView(
                        animationController: widget.animationController,
                        callBack: (index) {},
                      ),
                    );
                  } else if(index == 2) {
                    return TitleView(
                      titleTxt: AppLocalizations(context).of("best_deal"),
                      subTxt: AppLocalizations(context).of("view_all"),
                      animation: animation,
                      isLeftButton: true,
                      animationController: widget.animationController,
                      click: () {},
                    );
                  }else {
                    return getDealListView(index);
                  }
                  },
              ),
            ),

            _sliderUI(),
            _viewHotelsButton(_animationController),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: serachUI(),
            )
          ],
        ),
      ),

    );
  }





  Widget _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          // we calculate the opecity between 0.64 to 1.0
          var opecity = 1.0 -
              (_animationController.value > 0.64
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: sliderImageHieght * (1.0 - _animationController.value),
            child: HomeExploreSliderView(
              click: () {  },
              opValue: opecity,
            ),
          );
        },
      ),
    );
  }

  _viewHotelsButton(AnimationController animationController) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        var opecity = 1.0 -
            (_animationController.value > 0.64
                ? 1.0
                : _animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHieght * (1.0 - _animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: context.read<ThemeProvider>().languageType ==
                    LanguageType.ar
                    ? null
                    : 24,
                right: context.read<ThemeProvider>().languageType ==
                    LanguageType.ar
                    ? 24
                    : null,
                child: Opacity(
                  opacity: opecity,
                  child: CommonButton(
                    onTap: () {
                      if (opecity != 0) {
                        NavigationServices(context).gotoHotelHomeScreen();
                      }
                    },
                    buttonTextWidget: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        AppLocalizations(context).of("view_hotel"),
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget serachUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(38)),
          onTap: () {
              NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.search,
            enabled: false,
            text: AppLocalizations(context).of("where_are_you_going"),
          ),
        ),
      ),
    );
  }

  Widget getDealListView(int index) {
    var hotelList = HotelListData.hotelList;
    List<Widget> list = [];
    hotelList.forEach((f) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      list.add(
        HotelListViewPage(
          callback: () {
           NavigationServices(context).gotoHotelDetails(f);
          },
          hotelData: f,
          animation: animation,
          animationController: widget.animationController,
        ),
      );
    });
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: list,
      ),
    );
  }

}
