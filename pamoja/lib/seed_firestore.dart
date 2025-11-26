import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await seedUsers();
  await seedOpportunities();
  await seedApplications();
  await seedCommunityPosts();

  print("✅ All dummy data seeded successfully!");
}

final firestore = FirebaseFirestore.instance;

// ---------- Seed Users ----------
Future<void> seedUsers() async {
  for (int i = 1; i <= 5; i++) {
    final uid = 'user$i';
    await firestore.collection('users').doc(uid).set({
      "name": "User $i",
      "email": "user$i@example.com",
      "avatarUrl": "https://picsum.photos/100?random=$i",
      "role": i == 1 ? "admin" : "volunteer",
      "skills": ["Skill A", "Skill B"],
      "interests": ["Interest 1", "Interest 2"],
      "totalHours": i * 5,
      "completedActivities": i,
      "createdAt": FieldValue.serverTimestamp(),
    });
    print("Created user $uid");
  }
}

// ---------- Seed Opportunities ----------
Future<void> seedOpportunities() async {
  for (int i = 1; i <= 10; i++) {
    final oppId = 'opp$i';
    await firestore.collection('opportunities').doc(oppId).set({
      "title": "Volunteer Event $i",
      "description": "Description for event $i",
      "category": i % 2 == 0 ? "Education" : "Environment",
      "location": "Location $i",
      "timeCommitment": "${2 + i} hours",
      "requirements": "None",
      "imageUrl": "https://picsum.photos/200/30$i",
      "date": DateTime.now().add(Duration(days: i)).toIso8601String(),
      "createdAt": FieldValue.serverTimestamp(),
    });
    print("Created opportunity $oppId");
  }
}

// ---------- Seed Applications ----------
Future<void> seedApplications() async {
  for (int i = 1; i <= 15; i++) {
    final userId = 'user${(i % 5) + 1}'; // distribute across users
    final oppId = 'opp${(i % 10) + 1}'; // distribute across opportunities
    await firestore.collection('applications').add({
      "userId": userId,
      "opportunityId": oppId,
      "title": "Volunteer Event $oppId",
      "description": "Application for Volunteer Event $oppId",
      "imageUrl": "https://picsum.photos/200/300?random=$i",
      "status": "applied",
      "date":
          DateTime.now().add(Duration(days: oppId.length)).toIso8601String(),
      "progress": 0,
      "appliedAt": FieldValue.serverTimestamp(),
    });
    print("Created application for user $userId to $oppId");
  }
}

// ---------- Seed Community Posts ----------
Future<void> seedCommunityPosts() async {
  for (int i = 1; i <= 5; i++) {
    final userId = 'user${(i % 5) + 1}';
    await firestore.collection('community_posts').add({
      "authorId": userId,
      "authorName": "User $userId",
      "authorAvatar": "https://picsum.photos/100?random=$i",
      "content": "Excited to join volunteer events this week! Post #$i",
      "timestamp": FieldValue.serverTimestamp(),
      "likes": i * 2,
      "comments": i,
    });
    print("Created community post $i");
  }
}
