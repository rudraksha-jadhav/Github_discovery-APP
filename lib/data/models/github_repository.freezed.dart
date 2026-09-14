// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GithubRepository {

 String get name;@JsonKey(name: 'full_name', defaultValue: '') String get fullName;@JsonKey(name: 'html_url', defaultValue: '') String get htmlUrl; String? get description; String? get language;@JsonKey(name: 'stargazers_count', defaultValue: 0) int get stargazersCount;@JsonKey(name: 'forks_count', defaultValue: 0) int get forksCount;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(defaultValue: false) bool get fork;
/// Create a copy of GithubRepository
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GithubRepositoryCopyWith<GithubRepository> get copyWith => _$GithubRepositoryCopyWithImpl<GithubRepository>(this as GithubRepository, _$identity);

  /// Serializes this GithubRepository to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GithubRepository&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.language, language) || other.language == language)&&(identical(other.stargazersCount, stargazersCount) || other.stargazersCount == stargazersCount)&&(identical(other.forksCount, forksCount) || other.forksCount == forksCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fork, fork) || other.fork == fork));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,fullName,htmlUrl,description,language,stargazersCount,forksCount,updatedAt,fork);

@override
String toString() {
  return 'GithubRepository(name: $name, fullName: $fullName, htmlUrl: $htmlUrl, description: $description, language: $language, stargazersCount: $stargazersCount, forksCount: $forksCount, updatedAt: $updatedAt, fork: $fork)';
}


}

/// @nodoc
abstract mixin class $GithubRepositoryCopyWith<$Res>  {
  factory $GithubRepositoryCopyWith(GithubRepository value, $Res Function(GithubRepository) _then) = _$GithubRepositoryCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'full_name', defaultValue: '') String fullName,@JsonKey(name: 'html_url', defaultValue: '') String htmlUrl, String? description, String? language,@JsonKey(name: 'stargazers_count', defaultValue: 0) int stargazersCount,@JsonKey(name: 'forks_count', defaultValue: 0) int forksCount,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(defaultValue: false) bool fork
});




}
/// @nodoc
class _$GithubRepositoryCopyWithImpl<$Res>
    implements $GithubRepositoryCopyWith<$Res> {
  _$GithubRepositoryCopyWithImpl(this._self, this._then);

  final GithubRepository _self;
  final $Res Function(GithubRepository) _then;

/// Create a copy of GithubRepository
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? fullName = null,Object? htmlUrl = null,Object? description = freezed,Object? language = freezed,Object? stargazersCount = null,Object? forksCount = null,Object? updatedAt = freezed,Object? fork = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,stargazersCount: null == stargazersCount ? _self.stargazersCount : stargazersCount // ignore: cast_nullable_to_non_nullable
as int,forksCount: null == forksCount ? _self.forksCount : forksCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fork: null == fork ? _self.fork : fork // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GithubRepository].
extension GithubRepositoryPatterns on GithubRepository {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GithubRepository value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GithubRepository() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GithubRepository value)  $default,){
final _that = this;
switch (_that) {
case _GithubRepository():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GithubRepository value)?  $default,){
final _that = this;
switch (_that) {
case _GithubRepository() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'full_name', defaultValue: '')  String fullName, @JsonKey(name: 'html_url', defaultValue: '')  String htmlUrl,  String? description,  String? language, @JsonKey(name: 'stargazers_count', defaultValue: 0)  int stargazersCount, @JsonKey(name: 'forks_count', defaultValue: 0)  int forksCount, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(defaultValue: false)  bool fork)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GithubRepository() when $default != null:
return $default(_that.name,_that.fullName,_that.htmlUrl,_that.description,_that.language,_that.stargazersCount,_that.forksCount,_that.updatedAt,_that.fork);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'full_name', defaultValue: '')  String fullName, @JsonKey(name: 'html_url', defaultValue: '')  String htmlUrl,  String? description,  String? language, @JsonKey(name: 'stargazers_count', defaultValue: 0)  int stargazersCount, @JsonKey(name: 'forks_count', defaultValue: 0)  int forksCount, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(defaultValue: false)  bool fork)  $default,) {final _that = this;
switch (_that) {
case _GithubRepository():
return $default(_that.name,_that.fullName,_that.htmlUrl,_that.description,_that.language,_that.stargazersCount,_that.forksCount,_that.updatedAt,_that.fork);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'full_name', defaultValue: '')  String fullName, @JsonKey(name: 'html_url', defaultValue: '')  String htmlUrl,  String? description,  String? language, @JsonKey(name: 'stargazers_count', defaultValue: 0)  int stargazersCount, @JsonKey(name: 'forks_count', defaultValue: 0)  int forksCount, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(defaultValue: false)  bool fork)?  $default,) {final _that = this;
switch (_that) {
case _GithubRepository() when $default != null:
return $default(_that.name,_that.fullName,_that.htmlUrl,_that.description,_that.language,_that.stargazersCount,_that.forksCount,_that.updatedAt,_that.fork);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GithubRepository implements GithubRepository {
  const _GithubRepository({required this.name, @JsonKey(name: 'full_name', defaultValue: '') required this.fullName, @JsonKey(name: 'html_url', defaultValue: '') required this.htmlUrl, this.description, this.language, @JsonKey(name: 'stargazers_count', defaultValue: 0) required this.stargazersCount, @JsonKey(name: 'forks_count', defaultValue: 0) required this.forksCount, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(defaultValue: false) required this.fork});
  factory _GithubRepository.fromJson(Map<String, dynamic> json) => _$GithubRepositoryFromJson(json);

@override final  String name;
@override@JsonKey(name: 'full_name', defaultValue: '') final  String fullName;
@override@JsonKey(name: 'html_url', defaultValue: '') final  String htmlUrl;
@override final  String? description;
@override final  String? language;
@override@JsonKey(name: 'stargazers_count', defaultValue: 0) final  int stargazersCount;
@override@JsonKey(name: 'forks_count', defaultValue: 0) final  int forksCount;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(defaultValue: false) final  bool fork;

/// Create a copy of GithubRepository
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GithubRepositoryCopyWith<_GithubRepository> get copyWith => __$GithubRepositoryCopyWithImpl<_GithubRepository>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GithubRepositoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GithubRepository&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.language, language) || other.language == language)&&(identical(other.stargazersCount, stargazersCount) || other.stargazersCount == stargazersCount)&&(identical(other.forksCount, forksCount) || other.forksCount == forksCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fork, fork) || other.fork == fork));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,fullName,htmlUrl,description,language,stargazersCount,forksCount,updatedAt,fork);

@override
String toString() {
  return 'GithubRepository(name: $name, fullName: $fullName, htmlUrl: $htmlUrl, description: $description, language: $language, stargazersCount: $stargazersCount, forksCount: $forksCount, updatedAt: $updatedAt, fork: $fork)';
}


}

/// @nodoc
abstract mixin class _$GithubRepositoryCopyWith<$Res> implements $GithubRepositoryCopyWith<$Res> {
  factory _$GithubRepositoryCopyWith(_GithubRepository value, $Res Function(_GithubRepository) _then) = __$GithubRepositoryCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'full_name', defaultValue: '') String fullName,@JsonKey(name: 'html_url', defaultValue: '') String htmlUrl, String? description, String? language,@JsonKey(name: 'stargazers_count', defaultValue: 0) int stargazersCount,@JsonKey(name: 'forks_count', defaultValue: 0) int forksCount,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(defaultValue: false) bool fork
});




}
/// @nodoc
class __$GithubRepositoryCopyWithImpl<$Res>
    implements _$GithubRepositoryCopyWith<$Res> {
  __$GithubRepositoryCopyWithImpl(this._self, this._then);

  final _GithubRepository _self;
  final $Res Function(_GithubRepository) _then;

/// Create a copy of GithubRepository
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? fullName = null,Object? htmlUrl = null,Object? description = freezed,Object? language = freezed,Object? stargazersCount = null,Object? forksCount = null,Object? updatedAt = freezed,Object? fork = null,}) {
  return _then(_GithubRepository(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,stargazersCount: null == stargazersCount ? _self.stargazersCount : stargazersCount // ignore: cast_nullable_to_non_nullable
as int,forksCount: null == forksCount ? _self.forksCount : forksCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fork: null == fork ? _self.fork : fork // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
