import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopnestt_new/models/user_model.dart';
import 'base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(User user) async {
    bool userExist =
        (await _firebaseFirestore.collection('users').doc(user.id).get()).exists;
    if (userExist){
      return;
    } else {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toDocument());
    }


  }

  @override
  Stream<User> getUser(String userId) {
    print('Getting user data from cloud firestore');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap)=> User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument())
        .then(
        (value) => print('User Document Updated'),
    );
  }


}

