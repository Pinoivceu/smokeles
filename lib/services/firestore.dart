import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 //Create

  Future<void> saveUserProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("Pengguna belum login.");

    String uid = currentUser.uid;

    await _firestore.collection("users").doc(uid).set({
      "first_name": firstName,
      "last_name": lastName,
      "birth_date": birthDate,
      "gender": gender,
      "created_at": DateTime.now(),
    });
  }

// Create
  Future<void> saveSmokingData({
  required int cigarettesPerDay,
  required int pricePerPack,
  required int cigarettesPerPack,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("Pengguna belum login.");

    String uid = currentUser.uid;

    await _firestore.collection("users").doc(uid).collection("smoke").doc("info").set({
      "cigarettes_per_day": cigarettesPerDay,
      "price_per_pack": pricePerPack,
      "cigarettes_per_pack": cigarettesPerPack,
      "created_at": DateTime.now(),
    });
  }

 Future<void> saveSmokingHistory({
    required int cigarettesToday,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("Pengguna belum login.");

    String uid = currentUser.uid;
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}"; // Format tanggal

    await _firestore.collection("users").doc(uid).collection("history").doc(formattedDate).set({
      "Count": cigarettesToday,
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> fetchUserProfile() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("Pengguna belum login.");

    String uid = currentUser.uid;

    DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  Stream<List<Map<String, dynamic>>> fetchSmokingData() {
  User? currentUser = _auth.currentUser;
  if (currentUser == null) {
    throw Exception("Pengguna belum login.");
  }

  String uid = currentUser.uid;
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(Duration(days: 1));

  // Format tanggal menjadi "YYYY-MM-DD"
  String todayDate = "${now.year}-${now.month}-${now.day}";
  String kemarin = "${yesterday.year}-${yesterday.month}-${yesterday.day}";

  // Kembalikan Stream dari Firestore yang mendengarkan dokumen berdasarkan tanggal hari ini dan kemarin
  return _firestore
      .collection("users")
      .doc(uid)
      .collection("history")
      .where(FieldPath.documentId, whereIn: [todayDate, kemarin]) // Mengambil dokumen dengan ID hari ini dan kemarin
      .snapshots() // Mendengarkan perubahan pada dokumen
      .map((snapshot) {
        // Mengubah snapshot menjadi List<Map<String, dynamic>> dari setiap dokumen
        return snapshot.docs.map((doc) {
          return {
            'count': doc['Count'],      // Menambahkan 'count' dari data dokumen
            'tanggal': doc.id,          // Menambahkan 'tanggal' (ID dokumen) dari documentId
          };
        }).toList(); // Mengembalikan list data untuk dokumen-dokumen yang ada
      });
}


/*
  Future<Map<String, dynamic>?> fetchSmokingDataToday() async {
  User? currentUser = _auth.currentUser;
  if (currentUser == null) throw Exception("Pengguna belum login.");

  String uid = currentUser.uid;
  DateTime now = DateTime.now();

  // Format tanggal menjadi "YYYY-MM-DD"
  String todayDate = "${now.year}-${now.month}-${now.day}";

  // Ambil dokumen berdasarkan tanggal hari ini
  DocumentSnapshot snapshot = await _firestore
      .collection("users")
      .doc(uid)
      .collection("history")
      .doc(todayDate) // Mengambil dokumen dengan ID hari ini
      .get(); // Mengambil data dokumen

  if (snapshot.exists) {
    return snapshot.data() as Map<String, dynamic>;
  } else {
    // Jika dokumen tidak ada, kembalikan null atau data default
    return null;
  }
}*/
 Future<void> incrementCigarettesToday() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("Pengguna belum login.");

    String uid = currentUser.uid;
    DateTime now = DateTime.now();

    // Format tanggal menjadi "YYYY-MM-DD"
    String todayDate = "${now.year}-${now.month}-${now.day}";

    DocumentReference docRef = _firestore
        .collection("users")
        .doc(uid)
        .collection("history")
        .doc(todayDate);

    // Gunakan 'set' dengan 'merge: true' untuk membuat dokumen jika belum ada
    await docRef.set({
      'Count': FieldValue.increment(1),
    }, SetOptions(merge: true)).catchError((error) {
      // Tangani error jika diperlukan
      print("Failed to increment cigarettesToday: $error");
    });
  }


Future<Map<String, dynamic>?> fetchSmokingDataYesterday() async {
  User? currentUser = _auth.currentUser;
  if (currentUser == null) throw Exception("Pengguna belum login.");

  String uid = currentUser.uid;
  DateTime now = DateTime.now();

  // Format tanggal menjadi "YYYY-MM-DD"
 DateTime yesterday =  now.subtract(Duration(days: 1));

  String kemarin = "${yesterday.year}-${yesterday.month}-${yesterday.day}";

  // Ambil dokumen berdasarkan tanggal hari ini
  DocumentSnapshot snapshot = await _firestore
      .collection("users")
      .doc(uid)
      .collection("history")
      .doc(kemarin) // Mengambil dokumen dengan ID hari ini
      .get(); // Mengambil data dokumen

  if (snapshot.exists) {
    return snapshot.data() as Map<String, dynamic>;
  } else {
    // Jika dokumen tidak ada, kembalikan null atau data default
    return null;
  }
}

  /// Menghapus data tertentu dari subkoleksi `smoking_data`
  /// - Menghapus dokumen berdasarkan ID di subkoleksi
  Future<void> deleteSmokingData(String smokingDataId) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("Pengguna belum login.");

    String uid = currentUser.uid;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("smoking_data")
        .doc(smokingDataId)
        .delete();
  }

  
}


