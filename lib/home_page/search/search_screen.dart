// import 'dart:developer';

// import '../../riverpod/search_course_notifier.dart';
// import '../../utils/file_collection.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _CourseSearchScreenState();
// }

// class _CourseSearchScreenState extends State<SearchScreen> {
//   String searchKey = '';
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: const PreferredSize(
//       //   preferredSize: Size.fromHeight(40),
//       //   child: HeaderWidget(
//       //     text1: 'Search',
//       //     leading1: Icons.arrow_back,
//       //     isCenterTitle: true,
//       //   ),
//       // ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child:
//               Consumer<searchNotifierProvider>(builder: (context, ref, child) {
//             return Padding(
//                     padding:
//                         const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 50.0),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 50,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 10.0, right: 10),
//                             child: TextFormField(
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) async {
//                                 // setState(() {
//                                 //   searchKey = value.toLowerCase();
//                                 //   streamQuery = firestore
//                                 //       .collection('course')
//                                 //       .where('course_search',
//                                 //           isGreaterThanOrEqualTo: searchKey)
//                                 //       .where('course_search',
//                                 //           isLessThan: '${searchKey}z')
//                                 //       // .orderBy("course_id", descending: true)
//                                 //       .snapshots();

//                                 //   log(streamQuery.toString(),
//                                 //       name: 'streamQuery');
//                                 // });
//                               },
//                               controller: ref.searchController,
//                               focusNode: ref.searchFocusNode,
//                               decoration: InputDecoration(
//                                   hintText: 'Search Course',
//                                   isDense: true,
//                                   prefixIcon: const Icon(
//                                     Icons.search,
//                                     size: 20,
//                                   ),
//                                   suffixIcon: InkWell(
//                                     onTap: () {
//                                       ref.searchController.text = "";
//                                       // setState(() {
//                                       //   searchKey = '';
//                                       //   streamQuery = firestore
//                                       //       .collection('course')
//                                       //       .where('course_search',
//                                       //           isGreaterThanOrEqualTo:
//                                       //               searchKey.trim())
//                                       //       .where('course_search',
//                                       //           isLessThan:
//                                       //               '${searchKey.trim()}z')
//                                       //       // .orderBy("course_id", descending: true)
//                                       //       .snapshots();

//                                       //   log(streamQuery.toString(),
//                                       //       name: 'streamQuery');
//                                       // });
//                                     },
//                                     child: const Icon(
//                                       Icons.close,
//                                       size: 20,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: const BorderSide(
//                                           color: Colors.black)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: const BorderSide(
//                                           color: Colors.black)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: const BorderSide(
//                                           color: Colors.black))),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         // if (courses?.isEmpty ?? true) ...{
//                         //   const Center(child: Text('No courses found'))
//                         // },
//                         ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             // itemCount: courses?.length ?? 0,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 16.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     // context.pushNamed(
//                                     //     RouteNames.courseDetails,
//                                     //     queryParameters: {
//                                     //       "courseId": courses?[index]
//                                     //               ["course_id"] ??
//                                     //           ""
//                                     //     });
//                                   },
//                                   child: Card(
//                                     margin: EdgeInsets.zero,
//                                     child: Container(
//                                       padding: EdgeInsets.zero,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(12),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Stack(
//                                             clipBehavior: Clip.none,
//                                             children: [
                                              
//                                               Positioned.fill(
//                                                 bottom: -20,
//                                                 right: 10,
//                                                 child: Align(
//                                                   alignment:
//                                                       Alignment.bottomRight,
//                                                   child: ElevatedButton(
//                                                     style: ElevatedButton
//                                                         .styleFrom(
//                                                             backgroundColor:
//                                                                 secondaryColor,
//                                                             shape:
//                                                                 const RoundedRectangleBorder(
//                                                                     side:
//                                                                         BorderSide(
//                                                               color: Colors
//                                                                   .white,
//                                                             ))),
//                                                     onPressed: () {
//                                                       // context.pushNamed(
//                                                       //     RouteNames
//                                                       //         .courseDetails,
//                                                       //     queryParameters: {
//                                                       //       "courseId": courses?[
//                                                       //                   index]
//                                                       //               [
//                                                       //               "course_id"] ??
//                                                       //           ""
//                                                       //     });
//                                                     },
//                                                     child: const Text(
//                                                         "View Details"),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 16,
//                                           ),
//                                           // Padding(
//                                           //   padding:
//                                           //       const EdgeInsets.all(8.0),
//                                           //   child: Column(
//                                           //     crossAxisAlignment:
//                                           //         CrossAxisAlignment.start,
//                                           //     children: [
//                                           //       TextWidget(
//                                           //         text1: courses?[index]
//                                           //                 ["course_name"] ??
//                                           //             "",
//                                           //         color1: primaryColor,
//                                           //         size1: 18,
//                                           //         fontWeight1:
//                                           //             FontWeight.bold,
//                                           //       ),
//                                           //     ],
//                                           //   ),
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             })
//                       ],
//                     ),
//                   );
             
//           }),
//         ),
//       ),
//     );
//   }
// }
