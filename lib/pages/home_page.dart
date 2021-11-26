import 'package:flutter/material.dart';
import 'package:pix_key/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[4],
      appBar: AppBar(
        backgroundColor: colors[2],
        title: Text('Meu Pix'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                tileColor: colors[3],
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.vpn_key,
                  ),
                ),
                title: Text(
                  'BMG',
                ),
                subtitle: Text('AS34 JKS5 7986 SAD3'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Buscar'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      primary: colors[3],
                      elevation: 2,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
