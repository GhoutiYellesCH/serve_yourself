import 'dart:math';
import 'package:flutter/material.dart';
import 'package:serveyourself/helpers/design.dart';

class MosaicBackground extends StatelessWidget {
  final int rows;
  final int columns;

  const MosaicBackground({super.key, this.rows = 20, this.columns = 5});

  @override
  Widget build(BuildContext context) {
    final totalTiles = rows * columns;
    final tileSize = MediaQuery.of(context).size.width / columns;

    return Stack(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
          ),
          itemCount: totalTiles,
          itemBuilder: (context, index) {

            final random = Random(index); // consistent color per tile
            if (random.nextInt(3) == random.nextInt(3)){
            return Container(
              height: tileSize,
              width: tileSize,
              color: Color.fromARGB(255, 255, 255, 255),
            );
            }else if (random.nextInt(2) == random.nextInt(2)){
            return Container(
              height: tileSize,
              width: tileSize,
              color:   Color.fromARGB(190, 255, 95, 0),
            );
            }
            else if (random.nextInt(5) == random.nextInt(6)){
            return Container(
              height: tileSize,
              width: tileSize,
              color:   Color.fromARGB(255, 216, 139, 87),
            );
            }
            

final red = 250;                           // dominant red
final green = 205 - random.nextInt(10);   // slightly less than red
final blue = 170 - random.nextInt(20);    // even less, adds warmth


            final color = Color.fromARGB(255, red, green, blue);

            return Container(
              height: tileSize,
              width: tileSize,
              color: color,
            );
          },
        ),
      ],
    );
  }
}
