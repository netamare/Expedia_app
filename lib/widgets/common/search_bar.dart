import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

/// Renamed to `AppSearchBar` to avoid collision with Flutter's built-in `SearchBar`.
class AppSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchTap() {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Search'),
        content: Text('Search for "${_controller.text}" (fake API)'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: InkWell(
          onTap: _onSearchTap,
          child: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: Strings.searchHint,
                        border: InputBorder.none,
                        isDense: true),
                    onSubmitted: (_) => _onSearchTap(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.tune, color: Colors.white),
        ),
      )
    ]);
  }
}