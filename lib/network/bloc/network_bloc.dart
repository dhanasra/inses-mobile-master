import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inses_app/model/bookings.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/payment_history.dart';
import 'package:inses_app/model/review.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/view_models/profile_view_model.dart';

import 'network_event.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final AppRepository appRepository;

  NetworkBloc({@required this.appRepository})
      : assert(appRepository != null),
        super(Initial());

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {

    if (event is AddUser) {
      yield Loading();
      try {
        final String response = await appRepository.addUser(event.name, event.phone, event.password);
        if(response == "success"){
          yield RegisterSuccess();
        }else if(response == "Error"){
          yield RegisterError(error: "");
        }else{
          yield RegisterError(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is LoginUser) {
      yield Loading();
      try {
        final String response = await appRepository.userLogin(event.phone, event.password);
        if(response == "1"){
          yield LoginSuccess(id: "1");
        }else if(response == "2"){
          yield LoginSuccess(id: "2");
        }else if(response == "Error"){
          yield LoginError(error: "");
        }else{
          yield LoginError(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is Logout) {
      yield Loading();
      print('object');
      try {
        final String response = await appRepository.logout();
        if(response == "success"){
          yield LogoutSuccess();
        }else if(response == "Error"){
          yield LoginError(error: "");
        }else{
          yield LoginError(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetUserDetails) {
      yield Loading();
      try {
        final state = await appRepository.getUserDetails();
        yield state;
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is UpdateProfile) {
      yield Loading();
      print('object');
      try {
        final String response = await appRepository.updateProfile(event.name, event.phone);
        print(response);
        if(response == "success"){
          ProfileViewModel.name = event.name;
          ProfileViewModel.phone = event.phone;
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is UpdatePassword) {
      yield Loading();
      try {
        final String response = await appRepository.updatePassword(event.old,event.password);
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddUserAddress) {
      yield Loading();
      try {
        final String response = await appRepository.addUserAddress(event.address);
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetUserAddress) {
      yield Loading();
      try {
        final String response = await appRepository.getUserAddress();
        if(response == "success"){
          yield LogoutSuccess();
        }else if(response == "Error"){
          yield LoginError(error: "");
        }else{
          yield LoginError(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetCategories) {
      yield Loading();
      try {
        final List<CategoryModel> categories = await appRepository.getCategories();
        if(categories.isEmpty){
          yield Empty();
        }else{
          yield GotCategories(categories: categories);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetOffers) {
      yield Loading();
      try {
        final List<OfferModel> offers = await appRepository.getOffers();
        if(offers.isEmpty){
          yield Empty();
        }else{
          yield GotOffers(offers: offers);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetCategoryServices) {
      yield Loading();
      try {
        final List<ServiceModel> services = await appRepository.getCategoryServices(event.id);
        if(services.isEmpty){
          yield Empty();
        }else{
          yield GotServices(services: services);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetServices) {
      yield Loading();
      try {
        final List<ServiceModel> services = await appRepository.getServices();
        if(services.isEmpty){
          yield Empty();
        }else{
          yield GotServices(services: services);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddServiceEvent) {
      yield Loading();
      try {
        final String response = await appRepository.addService(
            name: event.name,
            image: event.image,
            icon: event.icon,
            price: event.price,
          categoryId: event.categoryId
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else if(response == "icon error"){
          yield Error(error: "Icon Size is Too Large");
        }else if(response == "image error"){
          yield Error(error: "Image Size is Too Large");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is EditService) {
      yield Loading();
      try {
        final String response = await appRepository.editService(
          name: event.name,
          id: event.id,
          categoryId: event.categoryId,
          price: event.price,
          icon: event.icon,
          image: event.image
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is DeleteService) {
      yield Loading();
      try {
        final String response = await appRepository.deleteService(
          serviceId: event.serviceId,
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddCategoryEvent) {
      yield Loading();
      try {
        final String response = await appRepository.addCategory(
            name: event.name,
            image: event.image
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else if(response == "icon error"){
          yield Error(error: "Icon Size is Too Large");
        }else if(response == "image error"){
          yield Error(error: "Image Size is Too Large");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddOfferEvent) {
      yield Loading();
      try {
        final String response = await appRepository.addOffer(
            txt: event.text,
            image: event.image,
            price:event.price,
          offer: event.offer
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else if(response == "icon error"){
          yield Error(error: "Icon Size is Too Large");
        }else if(response == "image error"){
          yield Error(error: "Image Size is Too Large");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is EditCategory) {
      yield Loading();
      try {
        final String response = await appRepository.editCategory(
            name: event.name,
            categoryId: event.categoryId,
            image: event.image
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is EditOfferEvent) {
      yield Loading();
      try {
        final String response = await appRepository.editOffer(
          id: event.id,
            txt: event.txt,
            image: event.image,
            price:event.price,
            offer: event.price
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is DeleteCategory) {
      print(2);
      yield Loading();
      try {
        final String response = await appRepository.deleteCategory(
            categoryId: event.categoryId,
        );
        if(response == "success"){
          print(2);
          yield Success();
        }else if(response == "Error"){
          print(2);
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is DeleteOffer) {
      print(2);
      yield Loading();
      try {
        final String response = await appRepository.deleteOffer(
          id: event.id,
        );
        if(response == "success"){
          print(2);
          yield Success();
        }else if(response == "Error"){
          print(2);
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddReview) {
      yield Loading();
      try {
        final String response = await appRepository.addReview(
          event.id,event.rating,event.comment
        );
        if(response == "success"){
          yield Success();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetReview) {
      yield Loading();
      try {
        final List<ReviewModel> reviews = await appRepository.getReviews();
        yield GotReviews(reviews: reviews);
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is RemoveAdditionalCharge) {
      yield Loading();
      try {
        final String response = await appRepository.deleteAdditional(event.id);
        if(response == "success"){
          yield AdditionalRemoved();
        }else if(response == "Error"){
          yield Error(error: "");
        }else{
          yield Error(error: response);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetBookings) {
      yield Loading();
      try {
        final List<BookingModel> bookings = await appRepository.getBookings("pending");

        if(bookings.isEmpty){
          yield Empty();
        }else{
          yield GotBookings(bookings: bookings);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetBookingHistory) {
      yield Loading();
      try {
        final List<BookingModel> bookings = await appRepository.getBookings("completed");

        if(bookings.isEmpty){
          yield Empty();
        }else{
          yield GotBookings(bookings: bookings);
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is BookService) {
      yield Loading();
      try {
        final String response = await appRepository.bookService(event.order);
        if(response=='success') {
          yield ServiceBooked();
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is ApproveOrder) {
      yield Loading();
      try {
        final String response = await appRepository.updateOrder(event.categoryId, 'approval');
        if(response=='success') {
          yield Approved();
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is GetBookingDetails) {
      yield Loading();
      try {
        final BookingModel bookingModel = await appRepository.getBookingDetails(event.id);
        yield GotBooking(booking: bookingModel);
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is CompleteOrder) {
      yield Loading();
      try {
        final String response = await appRepository.updateOrder(event.categoryId, 'complete');
        if(response=='success') {
          yield Completed();
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddMessage) {
      yield Loading();
      try {
        final String response = await appRepository.addMessage(event.message);
        if(response=='success') {
          yield MessageAdded();
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is UpdatePaymentStatus) {
      yield Loading();
      try {
        final String response = await appRepository.paymentStatus(event.orderId,event.paymentId,event.method);
        if(response=='success') {
          yield PaymentStatusUpdated();
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

    if (event is AddAdditionalCharge) {
      yield Loading();
      try {
        final String response = await appRepository.addAdditionalCharges(event.orderId,event.price,event.desc);
        if(response=='success') {
          yield Added();
        }
      } catch (e) {
        print(e);
        yield Error();
      }
    }

  }
}