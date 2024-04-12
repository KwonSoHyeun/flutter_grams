// import 'package:flutter/material.dart';

// class HomeKindWidget extends StatelessWidget {
//   HomeKindWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //  final consumer = Provider.of<ItemsViewModel>(context);
// final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');
//     return GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 6,
//           childAspectRatio: 1 / 2,
//         ),
//         itemCount: _items.length,
//         itemBuilder: (context, index) => Card(
//           margin: const EdgeInsets.all(8),
//           elevation: 8,
//           child: GridTile(
//             header: GridTileBar(
//               backgroundColor: Colors.black26,
//               title: const Text('header'),
//               subtitle: Text('Item ${_items[index].split(' ')[1]}'),
//             ),
//             footer: GridTileBar(
//               backgroundColor: Colors.black38,
//               title: const Text('footer'),
//               subtitle: Text('Item ${_items[index].split(' ')[1]}'),
//             ),
//             child: Center(
//               child: Text(
//                 _items[index],
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }
