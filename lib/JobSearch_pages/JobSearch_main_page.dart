import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/JobSearch_pages/JobList_widget.dart';

class JobSearch extends StatefulWidget {
  final String id;
  const JobSearch({super.key, required this.id});

  @override
  _JobsSearchState createState() => _JobsSearchState();
}

class _JobsSearchState extends State<JobSearch> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> jobs = [];
  //String? userDocId;

  @override
  void initState() {
    super.initState();
    _fetchJobsAndUserDocId();
  }
  Future<void> _fetchJobsAndUserDocId() async {
    try {
      //사용자id 가져오는 부분
      final QuerySnapshot resultId = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();
      final List<DocumentSnapshot> documentId = resultId.docs;

      if(documentId.isNotEmpty){
        final String docId = documentId.first.id;
      } else{
        print("JobSearch user not found");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("공고페이지에서 사용자가 확인되지 않았습니다.")),
        );
        return;
      }

      //job 정보 가져오는 부분
      final QuerySnapshot result = await _firestore.collection('jobs').get();
      final List<DocumentSnapshot> documents = result.docs;

      setState(() {
        jobs = documents.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          // null 값을 처리하는 부분
          return {
            'num' : data['num'] ?? 'No Num',
            'title': data['title'] ?? 'No Title.',
            'address': data['address']??'No address',
            'wage':data['wage']??'No Wage',
            'career': data['career']??'No Career',
            'detail': data['detail']?? 'No detail',
            'workweek': data['work_time_week']??'No work Week'
          };
        }).toList();
      });
    } catch (error) {
      print("Failed to fetch jobs: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch jobs: $error")),
      );
    }
  }
  // Firestore에서 jobs 컬렉션의 데이터를 가져오기


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('공고리스트'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(250, 51, 51, 255),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.grey,
            ),
          ),
          body: jobs.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: JobList(
                  title: job['title'],
                  address: job['address'],
                  wage: job['wage'],
                  career: job['career'],
                  detail: job['detail'],
                  workweek: job['workweek'],
                  id: widget.id,
                  num: job['num'],
                  isLiked: false,
                  //userDocId: userDocId ?? '',
                ),
              );
            },
          ),

        ),
      ),
    );
  }
}
