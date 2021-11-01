
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/model/profile_item.dart';
import 'package:my_first_flutter/style.dart';

class ProfilePage{

  static Widget builds(BuildContext context, ProfileItem profileItem){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 40)),
            Text("Hello ${profileItem.userName}",
                style: Theme.of(context).textTheme.headline3),
            const Padding(padding: EdgeInsets.only(top: 20)),
            CircleAvatar(
              radius: 100,
              child: ClipOval(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/id/d/d5/Aang_.jpg',
                  width: 500,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Text("Nama: Gayuh Nurul Huda\nUmur: 26\nTTL: Jakarta, 11 Mei 1995",
                style: CustomStyle.formEditText(context)),
          ],
        )
      );
  }
}