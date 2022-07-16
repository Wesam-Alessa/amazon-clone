// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = 'Amazon_Clone';
  static const int APP_VERSION = 1;
  static const String BASE_URL = 'http://192.168.8.103:3000';

  // Auth
  static const String REGISTRATION_URI = '/api/auth/signup';
  static const String LOGIN_URI = '/api/auth/signin';
  static const String AUTO_LOGIN_URI = '/api/auth/tokenIsValid';
  static const String AFTER_AUTO_LOGIN_URI = '/api/auth/';

  static const String TOKEN = '';
  static const String PASSWORD = '';

  // Admin
  static const String ADMIN_ADD_PRODUCT_URI = '/api/admin/add-product';
  static const String ADMIN_GET_PRODUCT_URI = '/api/admin/get-products';
  static const String ADMIN_DELETE_PRODUCT_URI = '/api/admin/delete-product';
  static const String ADMIN_GET_ORDERS_URI = '/api/admin/get-orders';
  static const String ADMIN_CHANGE_ORDER_STATUS_URI = '/api/admin/change-order-status';
  static const String ADMIN_GET_ANALYTICS_URI = '/api/admin/analytics';


  // get products
  static const String GET_PRODUCT_URI = '/api/products';
  static const String GET_SEARCH_PRODUCT_URI = '/api/products/search';
  static const String RATE_PRODUCT_URI = '/api/products/rate-products';
  static const String PRODUCT_DEAL_OF_DATE_URI = "/api/products/deal-of-date";

  // User  
    static const String USER_ADD_PRODUCT_TO_CART_URI = "/api/user/add-to-cart";
    static const String USER_REMOVE_PRODUCT_FROM_CART_URI = "/api/user/remove-from-cart";
    static const String SAVE_USER_ADDRESS_URI = "/api/user/save-user-address";
    static const String USER_ORDER_URI = "/api/user/order";
    static const String GET_USER_ORDER_URI = "/api/user/order/me";

  // static const String USER_INFO_URI = '/api/v1/customer/info';
  // static const String USER_ADDRESS = 'user_address';

}
