import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/core/network/api_service.dart';
import 'package:full_app/features/cart/data/cart_model.dart';

class CartRepo {
  final ApiService apiService = ApiService();

  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final res = await apiService.post('/cart/add', cartData.toJson());
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }
      throw ApiError(message: 'Product Added Successfully To Cart');
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<GetCartResponse?> getCartData() async {
    try {
      final res = await apiService.get('/cart');
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }

      return GetCartResponse.fromJson(res);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //delete CartItem
  Future<void> removeCartItem(int id) async {
    try {
      final res = await apiService.delete('/cart/remove/$id', {});
      if (res['code'] == 200 && res['data'] == null) {
        throw ApiError(message: res['Item deleted from cart']);
      }
    } catch (e) {
      ApiError(message: "Remove Item from Cart: ${e.toString()}");
    }
  }
}
