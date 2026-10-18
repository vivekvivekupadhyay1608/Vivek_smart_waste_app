import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. चेक करना कि क्या एंप्लॉई एडमिन द्वारा अप्रूव्ड है या नहीं
  static Future<bool> checkEmployeeApproval(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        // अगर 'isApproved' फील्ड true है तभी अंदर जाने देगा
        return data['isApproved'] ?? false;
      }
      return false;
    } catch (e) {
      print("Error checking approval: $e");
      return false;
    }
  }

  // 2. रिपोर्ट्स या शिकायतों को फेच करना (जो एडमिन और एंप्लॉई दोनों को दिखेंगी)
  static Stream<QuerySnapshot> getAssignedComplaints() {
    return _firestore.collection('reports').snapshots();
  }

  // 3. एंप्लॉई द्वारा काम पूरा होने पर स्टेटस और फोटो प्रूफ अपडेट करना
  static Future<void> updateTaskResolution(String reportId, String proofImageUrl) async {
    await _firestore.collection('reports').doc(reportId).update({
      'status': 'Resolved',
      'proofImage': proofImageUrl,
      'resolvedAt': FieldValue.serverTimestamp(),
    });
  }
}