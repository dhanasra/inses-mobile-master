import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:inses_app/model/bookings.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/payment_history.dart';
import 'package:inses_app/model/review.dart';
import 'package:inses_app/model/service.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class Initial extends NetworkState {}

class Loading extends NetworkState {}


class Empty extends NetworkState {}

class Error extends NetworkState {
  final String error;

  const Error({this.error});
}

class RegisterSuccess extends NetworkState {}

class AdditionalRemoved extends NetworkState {}

class RegisterError extends NetworkState {
  final String error;

  const RegisterError({@required this.error}):assert(error!=null);

}

class GotUserDetails extends NetworkState {
  final String name;
  final String phone;

  const GotUserDetails({this.name,this.phone});

}

class GotReviews extends NetworkState {
  final List<ReviewModel> reviews;

  const GotReviews({this.reviews});

}

class GotBooking extends NetworkState {
  final BookingModel booking;
  const GotBooking({this.booking});

}

class Success extends NetworkState {}

class LoginSuccess extends NetworkState {
  final String id;
  const LoginSuccess({this.id});
}

class LogoutSuccess extends NetworkState {}


class Approved extends NetworkState {}

class Completed extends NetworkState {}

class Added extends NetworkState {}

class LoginError extends NetworkState {
  final String error;

  const LoginError({@required this.error});

}

class GotCategories extends NetworkState {
  final List<CategoryModel> categories;

  const GotCategories({@required this.categories}) : assert(categories != null);

  @override
  List<Object> get props => [categories];
}

class GotServices extends NetworkState {
  final List<ServiceModel> services;

  const GotServices({@required this.services}) : assert(services != null);

  @override
  List<Object> get props => [services];
}

class GotOffers extends NetworkState {
  final List<OfferModel> offers;

  const GotOffers({@required this.offers}) : assert(offers != null);

  @override
  List<Object> get props => [offers];
}


class GotPaymentHistory extends NetworkState {
  final List<PaymentHistoryModel> payments;

  const GotPaymentHistory({@required this.payments}) : assert(payments != null);

  @override
  List<Object> get props => [payments];
}

class GotBookings extends NetworkState {
  final List<BookingModel> bookings;

  const GotBookings({@required this.bookings}) : assert(bookings != null);

  @override
  List<Object> get props => [bookings];
}

class GotBookingHistory extends NetworkState {
  final List<BookingModel> bookings;

  const GotBookingHistory({@required this.bookings}) : assert(bookings != null);

  @override
  List<Object> get props => [bookings];
}

class MessageAdded extends NetworkState {}

class PaymentStatusUpdated extends NetworkState {}

class PhoneNumberUpdated extends NetworkState {}

class ServiceBooked extends NetworkState {}