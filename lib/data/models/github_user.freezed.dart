// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GithubUser {

 String get login; String? get name;@JsonKey(name: 'avatar_url', defaultValue: '') String get avatarUrl;@JsonKey(name: 'html_url', defaultValue: '') String get htmlUrl; String? get bio;@JsonKey(name: 'public_repos', defaultValue: 0) int get publicRepos;@JsonKey(defaultValue: 0) int get followers;@JsonKey(defaultValue: 0) int get following; String? get company; String? get location; String? get blog;@JsonKey(name: 'created_at') DateTime? get createdAt; String? get type;
/// Create a copy of GithubUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GithubUserCopyWith<GithubUser> get copyWith => _$GithubUserCopyWithImpl<GithubUser>(this as GithubUser, _$identity);

  /// Serializes this GithubUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GithubUser&&(identical(other.login, login) || other.login == login)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.publicRepos, publicRepos) || other.publicRepos == publicRepos)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.following, following) || other.following == following)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.blog, blog) || other.blog == blog)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,name,avatarUrl,htmlUrl,bio,publicRepos,followers,following,company,location,blog,createdAt,type);

@override
String toString() {
  return 'GithubUser(login: $login, name: $name, avatarUrl: $avatarUrl, htmlUrl: $htmlUrl, bio: $bio, publicRepos: $publicRepos, followers: $followers, following: $following, company: $company, location: $location, blog: $blog, createdAt: $createdAt, type: $type)';
}


}

/// @nodoc
abstract mixin class $GithubUserCopyWith<$Res>  {
  factory $GithubUserCopyWith(GithubUser value, $Res Function(GithubUser) _then) = _$GithubUserCopyWithImpl;
@useResult
$Res call({
 String login, String? name,@JsonKey(name: 'avatar_url', defaultValue: '') String avatarUrl,@JsonKey(name: 'html_url', defaultValue: '') String htmlUrl, String? bio,@JsonKey(name: 'public_repos', defaultValue: 0) int publicRepos,@JsonKey(defaultValue: 0) int followers,@JsonKey(defaultValue: 0) int following, String? company, String? location, String? blog,@JsonKey(name: 'created_at') DateTime? createdAt, String? type
});




}
/// @nodoc
class _$GithubUserCopyWithImpl<$Res>
    implements $GithubUserCopyWith<$Res> {
  _$GithubUserCopyWithImpl(this._self, this._then);

  final GithubUser _self;
  final $Res Function(GithubUser) _then;

/// Create a copy of GithubUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? login = null,Object? name = freezed,Object? avatarUrl = null,Object? htmlUrl = null,Object? bio = freezed,Object? publicRepos = null,Object? followers = null,Object? following = null,Object? company = freezed,Object? location = freezed,Object? blog = freezed,Object? createdAt = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,publicRepos: null == publicRepos ? _self.publicRepos : publicRepos // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,blog: freezed == blog ? _self.blog : blog // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GithubUser].
extension GithubUserPatterns on GithubUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GithubUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GithubUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GithubUser value)  $default,){
final _that = this;
switch (_that) {
case _GithubUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GithubUser value)?  $default,){
final _that = this;
switch (_that) {
case _GithubUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String login,  String? name, @JsonKey(name: 'avatar_url', defaultValue: '')  String avatarUrl, @JsonKey(name: 'html_url', defaultValue: '')  String htmlUrl,  String? bio, @JsonKey(name: 'public_repos', defaultValue: 0)  int publicRepos, @JsonKey(defaultValue: 0)  int followers, @JsonKey(defaultValue: 0)  int following,  String? company,  String? location,  String? blog, @JsonKey(name: 'created_at')  DateTime? createdAt,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GithubUser() when $default != null:
return $default(_that.login,_that.name,_that.avatarUrl,_that.htmlUrl,_that.bio,_that.publicRepos,_that.followers,_that.following,_that.company,_that.location,_that.blog,_that.createdAt,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String login,  String? name, @JsonKey(name: 'avatar_url', defaultValue: '')  String avatarUrl, @JsonKey(name: 'html_url', defaultValue: '')  String htmlUrl,  String? bio, @JsonKey(name: 'public_repos', defaultValue: 0)  int publicRepos, @JsonKey(defaultValue: 0)  int followers, @JsonKey(defaultValue: 0)  int following,  String? company,  String? location,  String? blog, @JsonKey(name: 'created_at')  DateTime? createdAt,  String? type)  $default,) {final _that = this;
switch (_that) {
case _GithubUser():
return $default(_that.login,_that.name,_that.avatarUrl,_that.htmlUrl,_that.bio,_that.publicRepos,_that.followers,_that.following,_that.company,_that.location,_that.blog,_that.createdAt,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String login,  String? name, @JsonKey(name: 'avatar_url', defaultValue: '')  String avatarUrl, @JsonKey(name: 'html_url', defaultValue: '')  String htmlUrl,  String? bio, @JsonKey(name: 'public_repos', defaultValue: 0)  int publicRepos, @JsonKey(defaultValue: 0)  int followers, @JsonKey(defaultValue: 0)  int following,  String? company,  String? location,  String? blog, @JsonKey(name: 'created_at')  DateTime? createdAt,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _GithubUser() when $default != null:
return $default(_that.login,_that.name,_that.avatarUrl,_that.htmlUrl,_that.bio,_that.publicRepos,_that.followers,_that.following,_that.company,_that.location,_that.blog,_that.createdAt,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GithubUser implements GithubUser {
  const _GithubUser({required this.login, this.name, @JsonKey(name: 'avatar_url', defaultValue: '') required this.avatarUrl, @JsonKey(name: 'html_url', defaultValue: '') required this.htmlUrl, this.bio, @JsonKey(name: 'public_repos', defaultValue: 0) required this.publicRepos, @JsonKey(defaultValue: 0) required this.followers, @JsonKey(defaultValue: 0) required this.following, this.company, this.location, this.blog, @JsonKey(name: 'created_at') this.createdAt, this.type});
  factory _GithubUser.fromJson(Map<String, dynamic> json) => _$GithubUserFromJson(json);

@override final  String login;
@override final  String? name;
@override@JsonKey(name: 'avatar_url', defaultValue: '') final  String avatarUrl;
@override@JsonKey(name: 'html_url', defaultValue: '') final  String htmlUrl;
@override final  String? bio;
@override@JsonKey(name: 'public_repos', defaultValue: 0) final  int publicRepos;
@override@JsonKey(defaultValue: 0) final  int followers;
@override@JsonKey(defaultValue: 0) final  int following;
@override final  String? company;
@override final  String? location;
@override final  String? blog;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override final  String? type;

/// Create a copy of GithubUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GithubUserCopyWith<_GithubUser> get copyWith => __$GithubUserCopyWithImpl<_GithubUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GithubUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GithubUser&&(identical(other.login, login) || other.login == login)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.publicRepos, publicRepos) || other.publicRepos == publicRepos)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.following, following) || other.following == following)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.blog, blog) || other.blog == blog)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,name,avatarUrl,htmlUrl,bio,publicRepos,followers,following,company,location,blog,createdAt,type);

@override
String toString() {
  return 'GithubUser(login: $login, name: $name, avatarUrl: $avatarUrl, htmlUrl: $htmlUrl, bio: $bio, publicRepos: $publicRepos, followers: $followers, following: $following, company: $company, location: $location, blog: $blog, createdAt: $createdAt, type: $type)';
}


}

/// @nodoc
abstract mixin class _$GithubUserCopyWith<$Res> implements $GithubUserCopyWith<$Res> {
  factory _$GithubUserCopyWith(_GithubUser value, $Res Function(_GithubUser) _then) = __$GithubUserCopyWithImpl;
@override @useResult
$Res call({
 String login, String? name,@JsonKey(name: 'avatar_url', defaultValue: '') String avatarUrl,@JsonKey(name: 'html_url', defaultValue: '') String htmlUrl, String? bio,@JsonKey(name: 'public_repos', defaultValue: 0) int publicRepos,@JsonKey(defaultValue: 0) int followers,@JsonKey(defaultValue: 0) int following, String? company, String? location, String? blog,@JsonKey(name: 'created_at') DateTime? createdAt, String? type
});




}
/// @nodoc
class __$GithubUserCopyWithImpl<$Res>
    implements _$GithubUserCopyWith<$Res> {
  __$GithubUserCopyWithImpl(this._self, this._then);

  final _GithubUser _self;
  final $Res Function(_GithubUser) _then;

/// Create a copy of GithubUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? login = null,Object? name = freezed,Object? avatarUrl = null,Object? htmlUrl = null,Object? bio = freezed,Object? publicRepos = null,Object? followers = null,Object? following = null,Object? company = freezed,Object? location = freezed,Object? blog = freezed,Object? createdAt = freezed,Object? type = freezed,}) {
  return _then(_GithubUser(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,publicRepos: null == publicRepos ? _self.publicRepos : publicRepos // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,blog: freezed == blog ? _self.blog : blog // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
