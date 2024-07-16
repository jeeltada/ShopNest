import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopnestt_new/models/checkout_model.dart';
import 'package:shopnestt_new/repositories/checkouts/base_checkout_repository.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkouts').add(checkout.toDocument()); // Use toMap method instead of toDocument
  }

  Future<void> addCheckoutToFirestore(Checkout checkout) async {
    try {
      await _firebaseFirestore.collection('checkouts').add(checkout.toDocument());
      print('Checkout added to Firestore successfully!');
    } catch (e) {
      print('Error adding checkout to Firestore: $e');
    }
  }
}
