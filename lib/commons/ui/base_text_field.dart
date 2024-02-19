import 'package:flutter/material.dart';

class BaseTextField extends StatefulWidget {
  final String? title;
  final String placeholder;
  final bool isSecureText;
  final Function(String value) onValueChanged;
  final bool isEnabled;
  final Color? textColor;

  const BaseTextField({
    Key? key,
    this.title,
    required this.placeholder,
    this.isSecureText = false,
    required this.onValueChanged,
    this.isEnabled = true,
    this.textColor,
  }) : super(key: key);

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool isOnSecureMode = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title ?? "",
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.top,
                      enabled: widget.isEnabled,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      obscureText: widget.isSecureText && isOnSecureMode,
                      scrollPadding: EdgeInsets.zero,
                      onChanged: widget.onValueChanged,
                      style: const TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        border: InputBorder.none,
                        hintText: widget.placeholder,
                        hintStyle: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  if (widget.isSecureText)
                    InkWell(
                      onTap: () {
                        setState(() {
                          isOnSecureMode = !isOnSecureMode;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: Icon(
                          isOnSecureMode
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
