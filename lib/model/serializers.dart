library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:document_scanner/model/thread.dart';

import 'api_error.dart';
import 'app_state.dart';
import 'message.dart';


part 'serializers.g.dart';

@SerializersFor(<Type>[
  Message,
  Content,
  ImageUrl,
  Thread,
  AppState,
  ApiError,
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
