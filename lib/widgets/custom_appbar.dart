import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: IntrinsicWidth(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Center(
                child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(
                      color: Colors.white,
                    )
                )
            ),
          ),
        ),

      ),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, '/wishlist');
        }, icon: Icon(Icons.favorite)),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

