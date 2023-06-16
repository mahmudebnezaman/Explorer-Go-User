import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

// User? currentUser = auth.currentUser;

//collections
const usersCollection = 'users';
const blogsCollection = 'blogs';
const eventsCollection = 'events';
const bookingsCollection = 'bookings';
const chatsCollection = 'chats';
const messagesCollection = 'messages';
const promotionalCollection = 'promotions';