import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child:
          loading ? const CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ) :
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
