
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/page route/page_route.dart';
import '../../../../constants/export.dart';
import '../../../../constants/util/useful_methods.dart';
import '../../../../globalwidget/export.dart';
import '../../data/local/booking_images.dart';
import '../bloc/cubit/booking_cubit.dart';

class Bookings extends StatelessWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        isloading: context.watch<BookingCubit>().state is BookingLoadingState,
        color: Appcolors.blue,
        body: Column(children: [
          BookingAppbar(size: size),
          SizedBox(height: size.height * 0.03),
          Expanded(
              child: Container(
                  width: size.width,
                  color: Appcolors.white,
                  child: Column(children: [
                    SizedBox(height: size.height * 0.02),
                    BookingFilter(size: size),
                    SizedBox(height: size.height * 0.02),
                    AllBookings(size: size)
                  ])))
        ]));
  }
}

class AllBookings extends StatelessWidget {
  const AllBookings({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final readBooking = context.read<BookingCubit>();
    final bookings = context.watch<BookingCubit>().filteredBooking;
    return Expanded(
        child: bookings.isNotEmpty
            ? ListView(
                children: List.generate(
                    bookings.length,
                    (index) => AppshadowContainer(
                        onTap: () {
                          readBooking.selectBooking(booking: bookings[index]);
                          Navigator.pushNamed(context, RouteName.bookingDetail);
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.width * 0.03),
                        margin: EdgeInsets.symmetric(
                            vertical: size.width * 0.02,
                            horizontal: size.width * 0.03),
                        width: size.width,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                        text:
                                            "${bookings[index].referenceNumber}",
                                        color: Appcolors.blue,
                                        size: 16),
                                    Appbutton(
                                        width: size.width * 0.25,
                                        height: size.height * 0.03,
                                        child: AppText(
                                            text: '${bookings[index].status}',
                                            size: 12,
                                            color: Appcolors.white,
                                            fontweight: FontWeight.w600))
                                  ]),
                              AppText(
                                  text: '${bookings[index].artisanName}',
                                  color: Appcolors.blue,
                                  size: 16,
                                  fontweight: FontWeight.w500),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                        text: 'CCtv instalation',
                                        fontweight: FontWeight.w600,
                                        color: Appcolors.blue),
                                    AppText(
                                        text:
                                            '${Utils.formatPrice(value: bookings[index].cost ?? '0')}',
                                        size: 14,
                                        color: Appcolors.blue,
                                        fontweight: FontWeight.w600)
                                  ]),
                              AppText(
                                  text:
                                      '${Utils.formatDate(value: bookings[index].date!).month} ${Utils.formatDate(value: bookings[index].date!).date} ${Utils.formatTime(value: bookings[index].time!)}',
                                  size: 14,
                                  color: Appcolors.blue),
                              Divider(color: Appcolors.lightgrey),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(Icons.phone, size: 20.sp),
                                      SizedBox(width: size.width * 0.02),
                                      AppText(
                                          text: 'Call',
                                          fontweight: FontWeight.w600,
                                          size: 16,
                                          color: Appcolors.blue)
                                    ]),
                                    Visibility(
                                        visible:
                                            bookings[index].status == 'pending',
                                        child: Appbutton(
                                            onTap: () {
                                              readBooking.selectBooking(
                                                  booking: bookings[index]);
                                              readBooking.cancelBooking();
                                            },
                                            width: size.width * 0.3,
                                            height: size.height * 0.045,
                                            label: 'Cancel'))
                                  ])
                            ]))))
            : Column(children: [
                SizedBox(height: size.height * 0.08),
                Image.asset(BookingImage.emptyBooking),
                AppText(
                    fontweight: FontWeight.w600,
                    color: Appcolors.blue,
                    text:
                        'No ${context.watch<BookingCubit>().bookingFilter} Bookings')
              ]));
  }
}

class BookingFilter extends StatelessWidget {
  const BookingFilter({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final watchBookingCubit = context.watch<BookingCubit>();
    final readBookingCubit = context.read<BookingCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.5,
          child: GestureDetector(
            onTap: () => readBookingCubit.selectBookingFilter(filter: 'Active'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: AppText(
                        text: 'Active', color: Appcolors.blue, size: 20)),
                ActiveIBookingndicator(
                    size: size,
                    activeColor: watchBookingCubit.bookingFilter == 'Active'
                        ? Appcolors.blue
                        : Appcolors.white),
              ],
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.5,
          child: GestureDetector(
            onTap: () =>
                readBookingCubit.selectBookingFilter(filter: 'Completed'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                    child: AppText(
                        text: 'Completed', color: Appcolors.blue, size: 20)),
                ActiveIBookingndicator(
                    size: size,
                    activeColor: watchBookingCubit.bookingFilter == 'Completed'
                        ? Appcolors.blue
                        : Appcolors.white),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BookingAppbar extends StatelessWidget {
  const BookingAppbar({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
              text: 'Bookings',
              color: Appcolors.white,
              fontweight: FontWeight.w600),
          const NotificationIcon()
        ],
      ),
    );
  }
}

class ActiveIBookingndicator extends StatelessWidget {
  const ActiveIBookingndicator(
      {super.key, required this.size, required this.activeColor});

  final Size size;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.5,
      decoration:
          BoxDecoration(border: Border.all(width: 3.5, color: activeColor)),
    );
  }
}
