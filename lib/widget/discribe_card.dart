import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'shadowed_container.dart';

class CustomTextContainer extends StatelessWidget {
  final String textContent;

  const CustomTextContainer({
    super.key,
    required this.textContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            textContent,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}

class LaunchUrlContainer extends StatelessWidget {
  final String textContent;
  final String url;

  const LaunchUrlContainer({
    super.key,
    required this.textContent,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLaunchUrl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
        child: ShadowedContainer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(textContent),
                  const Icon(Icons.open_in_new),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> onLaunchUrl() async {
    final Uri parsedUrl = Uri.parse(url);
    if (await canLaunchUrl(parsedUrl)) {
      await launchUrl(parsedUrl);
    } else {
      // エラーハンドリング: URLを開けない場合の処理
    }
  }
}