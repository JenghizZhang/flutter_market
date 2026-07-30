import 'package:flutter_base/constants/index.dart';
import 'package:flutter_base/utils/DioRequest.dart';
import 'package:flutter_base/viewmodels/home.dart';

Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async {
  DioRequest dioRequest = DioRequest();
  return GoodsDetailsItems.formJSON(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
