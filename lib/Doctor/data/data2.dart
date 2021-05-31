// Food
import 'package:patient_app/models/food.dart';
import 'package:patient_app/models/order.dart';
import 'package:patient_app/models/restaurant.dart';
import 'package:patient_app/models/user.dart';

final _burrito =
Food(imageUrl: 'assets/category1.png', name: 'Fees', price: 8.99);
final _steak =
Food(imageUrl: 'assets/category2.png', name: 'Fees', price: 17.99);
final _pasta =
Food(imageUrl: 'assets/category3.jpg', name: 'Fees', price: 14.99);


// Restaurants
final _restaurant0 = Restaurant(
  imageUrl: 'assets/user.jpg',
  name: 'Sonia Rbii',
  address: 'Gafsa - Tunisia',
  rating: 5,
  menu: [_burrito, _steak, _pasta],
);
final _restaurant1 = Restaurant(
  imageUrl: 'assets/user0.jpg',
  name: 'Ayoub Balti',
  address: 'Benzart - Tunisia',
  rating: 4,
  menu: [_steak, _pasta],
);
final _restaurant2 = Restaurant(
  imageUrl: 'assets/user1.jpg',
  name: 'Meriam Hamdani',
  address: 'Sfax - Tunisia',
  rating: 4,
  menu: [_steak, _pasta],
);


final List<Restaurant> restaurants = [
  _restaurant0,
  _restaurant1,
  _restaurant2,

];

// User
final nowUser = User(
  name: 'Rebecca',
  orders: [
    Order(
      date: 'Nov 10, 2019',
      food: _steak,
      restaurant: _restaurant2,
      quantity: 1,
    ),
    Order(
      date: 'Nov 5, 2019',
      food: _burrito,
      restaurant: _restaurant1,
      quantity: 2,
    ),
  ],
  cart: [
    Order(
      date: 'Nov 11, 2021',
      food: _pasta,
      restaurant: _restaurant2,
      quantity: 1,
    ),
    Order(
      date: 'Nov 11, 2019',
      food: _burrito,
      restaurant: _restaurant1,
      quantity: 2,
    ),
  ],
);