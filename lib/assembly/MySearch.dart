// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/views/public/ArticleSearchPage.dart';
import 'package:ltpp/views/public/ChatSearchPage.dart';
import 'package:ltpp/views/public/ContestSearchPage.dart';
import 'package:ltpp/views/public/OjSearchPage.dart';

// ignore: must_be_immutable
class MySearch extends StatefulWidget {
  String new_page_name;
  MySearch({super.key, required this.new_page_name});
  @override
  // ignore: library_private_types_in_public_api
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  // ignore: unused_field
  String _search_query = '';
  TextEditingController key_controller = TextEditingController();

  void _executeSearch() {
    _search_query = key_controller.text;
    switch (widget.new_page_name) {
      case 'ArticleSearchPage':
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArticleSearchPage(search_key: _search_query),
                  fullscreenDialog: true,
                  maintainState: true));
        }
        break;
      case 'ChatSearchPage':
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatSearchPage(search_key: _search_query),
                  fullscreenDialog: true,
                  maintainState: true));
        }
        break;
      case 'ContestSearchPage':
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ContestSearchPage(search_key: _search_query),
                  fullscreenDialog: true,
                  maintainState: true));
        }
        break;
      case 'OjSearchPage':
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OjSearchPage(search_key: _search_query),
                  fullscreenDialog: true,
                  maintainState: true));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: key_controller,
              autofocus: false,
              decoration: const InputDecoration(
                hintText: '请输入关键字',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.grey,
            onPressed: _executeSearch,
          ),
        ],
      ),
    );
  }
}
