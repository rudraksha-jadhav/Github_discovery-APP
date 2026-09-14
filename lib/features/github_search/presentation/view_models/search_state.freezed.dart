// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {

 List<String> get recentSearches;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&const DeepCollectionEquality().equals(other.recentSearches, recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(recentSearches));

@override
String toString() {
  return 'SearchState(recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 List<String> recentSearches
});




}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recentSearches = null,}) {
  return _then(_self.copyWith(
recentSearches: null == recentSearches ? _self.recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<String> recentSearches)?  initial,TResult Function( String username,  List<String> recentSearches)?  loading,TResult Function( GithubUser user,  List<GithubRepository> repositories,  String searchedUsername,  List<String> recentSearches)?  success,TResult Function( ApiException exception,  String searchedUsername,  List<String> recentSearches)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.recentSearches);case _Loading() when loading != null:
return loading(_that.username,_that.recentSearches);case _Success() when success != null:
return success(_that.user,_that.repositories,_that.searchedUsername,_that.recentSearches);case _Error() when error != null:
return error(_that.exception,_that.searchedUsername,_that.recentSearches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<String> recentSearches)  initial,required TResult Function( String username,  List<String> recentSearches)  loading,required TResult Function( GithubUser user,  List<GithubRepository> repositories,  String searchedUsername,  List<String> recentSearches)  success,required TResult Function( ApiException exception,  String searchedUsername,  List<String> recentSearches)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.recentSearches);case _Loading():
return loading(_that.username,_that.recentSearches);case _Success():
return success(_that.user,_that.repositories,_that.searchedUsername,_that.recentSearches);case _Error():
return error(_that.exception,_that.searchedUsername,_that.recentSearches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<String> recentSearches)?  initial,TResult? Function( String username,  List<String> recentSearches)?  loading,TResult? Function( GithubUser user,  List<GithubRepository> repositories,  String searchedUsername,  List<String> recentSearches)?  success,TResult? Function( ApiException exception,  String searchedUsername,  List<String> recentSearches)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.recentSearches);case _Loading() when loading != null:
return loading(_that.username,_that.recentSearches);case _Success() when success != null:
return success(_that.user,_that.repositories,_that.searchedUsername,_that.recentSearches);case _Error() when error != null:
return error(_that.exception,_that.searchedUsername,_that.recentSearches);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SearchState {
  const _Initial({final  List<String> recentSearches = const []}): _recentSearches = recentSearches;
  

 final  List<String> _recentSearches;
@override@JsonKey() List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.initial(recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 List<String> recentSearches
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recentSearches = null,}) {
  return _then(_Initial(
recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _Loading implements SearchState {
  const _Loading({required this.username, final  List<String> recentSearches = const []}): _recentSearches = recentSearches;
  

 final  String username;
 final  List<String> _recentSearches;
@override@JsonKey() List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.username, username) || other.username == username)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,username,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.loading(username: $username, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 String username, List<String> recentSearches
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? recentSearches = null,}) {
  return _then(_Loading(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _Success implements SearchState {
  const _Success({required this.user, required final  List<GithubRepository> repositories, required this.searchedUsername, final  List<String> recentSearches = const []}): _repositories = repositories,_recentSearches = recentSearches;
  

 final  GithubUser user;
 final  List<GithubRepository> _repositories;
 List<GithubRepository> get repositories {
  if (_repositories is EqualUnmodifiableListView) return _repositories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repositories);
}

 final  String searchedUsername;
 final  List<String> _recentSearches;
@override@JsonKey() List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._repositories, _repositories)&&(identical(other.searchedUsername, searchedUsername) || other.searchedUsername == searchedUsername)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(_repositories),searchedUsername,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.success(user: $user, repositories: $repositories, searchedUsername: $searchedUsername, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 GithubUser user, List<GithubRepository> repositories, String searchedUsername, List<String> recentSearches
});


$GithubUserCopyWith<$Res> get user;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? repositories = null,Object? searchedUsername = null,Object? recentSearches = null,}) {
  return _then(_Success(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as GithubUser,repositories: null == repositories ? _self._repositories : repositories // ignore: cast_nullable_to_non_nullable
as List<GithubRepository>,searchedUsername: null == searchedUsername ? _self.searchedUsername : searchedUsername // ignore: cast_nullable_to_non_nullable
as String,recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GithubUserCopyWith<$Res> get user {
  
  return $GithubUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _Error implements SearchState {
  const _Error({required this.exception, required this.searchedUsername, final  List<String> recentSearches = const []}): _recentSearches = recentSearches;
  

 final  ApiException exception;
 final  String searchedUsername;
 final  List<String> _recentSearches;
@override@JsonKey() List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.exception, exception) || other.exception == exception)&&(identical(other.searchedUsername, searchedUsername) || other.searchedUsername == searchedUsername)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,exception,searchedUsername,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'SearchState.error(exception: $exception, searchedUsername: $searchedUsername, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 ApiException exception, String searchedUsername, List<String> recentSearches
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exception = null,Object? searchedUsername = null,Object? recentSearches = null,}) {
  return _then(_Error(
exception: null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as ApiException,searchedUsername: null == searchedUsername ? _self.searchedUsername : searchedUsername // ignore: cast_nullable_to_non_nullable
as String,recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
