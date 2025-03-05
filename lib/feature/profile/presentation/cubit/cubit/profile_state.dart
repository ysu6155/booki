part of 'profile_cubit.dart';

abstract class ProfileState {
 
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String image;

  ProfileLoaded({required this.name, required this.email, required this.image});

  @override
  List<Object?> get props => [name, email, image];
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}


class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);

  @override
  List<Object> get props => [message];
}

