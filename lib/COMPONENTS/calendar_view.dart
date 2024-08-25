import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/colors.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/date.dart';

class CalendarView extends StatefulWidget {
  final Color backgroundColor;
  final Function(DateTime) onTapDate;
  final Set<DateTime> highlightedDates;
  final Set<DateTime> disabledDates;
  final bool startToday;
  final Color selectedColor;
  final Color selectedTextColor;

  CalendarView({
    super.key,
    this.backgroundColor = Colors.black12,
    required this.onTapDate,
    List<DateTime>? highlightedDates,
    List<DateTime>? disabledDates,
    this.startToday = false,
    this.selectedColor = Colors.black,
    this.selectedTextColor = Colors.white,
  })  : highlightedDates = Set.from(highlightedDates ?? []),
        disabledDates = Set.from(disabledDates ?? []);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _getInitialPage(),
    );
  }

  int _getInitialPage() {
    if (widget.startToday) {
      final today = DateTime.now();
      final currentYear = today.year;
      if (currentYear == 2024) {
        return getMonthsOfYear(currentYear).indexOf(getMonthName(today.month));
      }
    }
    return 0; // Default to the first month
  }

  void onTappedDate(DateTime date) {
    if (!widget.disabledDates.contains(date)) {
      widget.onTapDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: getMonthsOfYear(2024).length,
              itemBuilder: (context, index) {
                final month = getMonthsOfYear(2024)[index];
                int firstDayOfMonthWeekday =
                    DateTime(2024, getMonthNum(month), 1).weekday;
                int blankDays = firstDayOfMonthWeekday % 7;

                return PaddingView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: month,
                        weight: FontWeight.w700,
                        size: 26,
                      ),
                      const PaddingView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(text: "S"),
                            TextView(text: "M"),
                            TextView(text: "T"),
                            TextView(text: "W"),
                            TextView(text: "T"),
                            TextView(text: "F"),
                            TextView(text: "S"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: blankDays +
                              getDaysOfMonth(getMonthNum(month), 2024).length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1.2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (context, gridIndex) {
                            if (gridIndex < blankDays) {
                              return const SizedBox.shrink();
                            }
                            final dayIndex = gridIndex - blankDays;
                            final day = getDaysOfMonth(
                                getMonthNum(month), 2024)[dayIndex];
                            final date =
                                DateTime(2024, getMonthNum(month), day);
                            final isHighlighted =
                                widget.highlightedDates.contains(date);
                            final isDisabled =
                                widget.disabledDates.contains(date) ||
                                    (widget.startToday &&
                                        date.isBefore(DateTime.now()));

                            return ButtonView(
                              radius: 100,
                              isDisabled: isDisabled,
                              backgroundColor: isHighlighted
                                  ? widget.selectedColor
                                  : widget.backgroundColor,
                              onPress: () {
                                onTappedDate(date);
                              },
                              child: Center(
                                child: TextView(
                                  text: day.toString(),
                                  size: 18,
                                  weight: FontWeight.w500,
                                  color: isDisabled
                                      ? Colors.grey
                                      : isHighlighted
                                          ? widget.selectedTextColor
                                          : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: getMonthsOfYear(2024).length,
            effect: const ScrollingDotsEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotScale: 1.5, // Controls the scale of the active dot
              spacing: 12,
              dotColor: Colors.grey,
              activeDotColor: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
