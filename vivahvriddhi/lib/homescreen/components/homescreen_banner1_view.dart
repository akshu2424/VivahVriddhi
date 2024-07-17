import 'package:vivahvriddhi/main.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../components/vivahvriddhi_app_theme.dart';
class Sucessful_Wedding_Banner1_View extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const Sucessful_Wedding_Banner1_View(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: VivahVriddhiAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: VivahVriddhiAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: HexColor('#87A0E5')
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                'Discover True Love',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      VivahVriddhiAppTheme
                                                          .fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: VivahVriddhiAppTheme
                                                      .grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                // SizedBox(
                                                //   width: 28,
                                                //   height: 28,
                                                //   child: Image.asset(
                                                //       "assets/sucessful_weddings/sucessful.png"),
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4, bottom: 3),
                                                  child: Text(
                                                    //'${(100 * animation!.value).toInt()}',
                                                    'VivahVriddhi',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          VivahVriddhiAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color:
                                                          VivahVriddhiAppTheme
                                                              .darkerText,
                                                    ),
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 4, bottom: 2),
                                                //   child: Text(
                                                //     '+',
                                                //     textAlign: TextAlign.center,
                                                //     style: TextStyle(
                                                //       fontFamily:
                                                //           VivahVriddhiAppTheme
                                                //               .fontName,
                                                //       fontWeight:
                                                //           FontWeight.w600,
                                                //       fontSize: 20,
                                                //       letterSpacing: -0.2,
                                                //       color:
                                                //           VivahVriddhiAppTheme
                                                //               .grey
                                                //               .withOpacity(0.5),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F56E98')
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                'Join Us on Our Journey to',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      VivahVriddhiAppTheme
                                                          .fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  letterSpacing: -0.1,
                                                  color: VivahVriddhiAppTheme
                                                      .grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                'Creating Lasting Connections.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      VivahVriddhiAppTheme
                                                          .fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  letterSpacing: -0.1,
                                                  color: VivahVriddhiAppTheme
                                                      .grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.center,
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.end,
                                            //   children: <Widget>[
                                            //     SizedBox(
                                            //       width: 28,
                                            //       height: 28,
                                            //       child: Image.asset(
                                            //           "assets/vivahvriddhi/burned.png"),
                                            //     ),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //               left: 4, bottom: 3),
                                            //       child: Text(
                                            //         '${(102 * animation!.value).toInt()}',
                                            //         textAlign: TextAlign.center,
                                            //         style: TextStyle(
                                            //           fontFamily:
                                            //               VivahVriddhiAppTheme
                                            //                   .fontName,
                                            //           fontWeight:
                                            //               FontWeight.w600,
                                            //           fontSize: 16,
                                            //           color:
                                            //               VivahVriddhiAppTheme
                                            //                   .darkerText,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //               left: 8, bottom: 3),
                                            //       child: Text(
                                            //         'Kcal',
                                            //         textAlign: TextAlign.center,
                                            //         style: TextStyle(
                                            //           fontFamily:
                                            //               VivahVriddhiAppTheme
                                            //                   .fontName,
                                            //           fontWeight:
                                            //               FontWeight.w600,
                                            //           fontSize: 12,
                                            //           letterSpacing: -0.2,
                                            //           color:
                                            //               VivahVriddhiAppTheme
                                            //                   .grey
                                            //                   .withOpacity(0.5),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Center(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/sucessful_weddings/hinduwedding.png', // Replace with your image asset path
                                        width: 108,
                                        height: 108,
                                        fit: BoxFit
                                            .cover, // Adjust the fit as needed
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: VivahVriddhiAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),


                    // upcoming you can update it later 
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 24, right: 24, top: 8, bottom: 16),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: <Widget>[
                    //             Text(
                    //               'Marriage milestones',
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                 fontFamily: VivahVriddhiAppTheme.fontName,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 10,
                    //                 letterSpacing: -0.2,
                    //                 color: VivahVriddhiAppTheme.darkText,
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(top: 4),
                    //               child: Container(
                    //                 height: 4,
                    //                 width: 70,
                    //                 decoration: BoxDecoration(
                    //                   color:
                    //                       HexColor('#87A0E5').withOpacity(0.2),
                    //                   borderRadius: BorderRadius.all(
                    //                       Radius.circular(4.0)),
                    //                 ),
                    //                 child: Row(
                    //                   children: <Widget>[
                    //                     Container(
                    //                       width:
                    //                           ((70 / 1.2) * animation!.value),
                    //                       height: 4,
                    //                       decoration: BoxDecoration(
                    //                         gradient: LinearGradient(colors: [
                    //                           HexColor('#87A0E5'),
                    //                           HexColor('#87A0E5')
                    //                               .withOpacity(0.5),
                    //                         ]),
                    //                         borderRadius: BorderRadius.all(
                    //                             Radius.circular(4.0)),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(top: 6),
                    //               child: Text(
                    //                 '5',
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                   fontFamily: VivahVriddhiAppTheme.fontName,
                    //                   fontWeight: FontWeight.w600,
                    //                   fontSize: 12,
                    //                   color: VivahVriddhiAppTheme.grey
                    //                       .withOpacity(0.5),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: <Widget>[
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Protein',
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                     fontFamily:
                    //                         VivahVriddhiAppTheme.fontName,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 16,
                    //                     letterSpacing: -0.2,
                    //                     color: VivahVriddhiAppTheme.darkText,
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 4),
                    //                   child: Container(
                    //                     height: 4,
                    //                     width: 70,
                    //                     decoration: BoxDecoration(
                    //                       color: HexColor('#F56E98')
                    //                           .withOpacity(0.2),
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(4.0)),
                    //                     ),
                    //                     child: Row(
                    //                       children: <Widget>[
                    //                         Container(
                    //                           width: ((70 / 2) *
                    //                               animationController!.value),
                    //                           height: 4,
                    //                           decoration: BoxDecoration(
                    //                             gradient:
                    //                                 LinearGradient(colors: [
                    //                               HexColor('#F56E98')
                    //                                   .withOpacity(0.1),
                    //                               HexColor('#F56E98'),
                    //                             ]),
                    //                             borderRadius: BorderRadius.all(
                    //                                 Radius.circular(4.0)),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 6),
                    //                   child: Text(
                    //                     '30g left',
                    //                     textAlign: TextAlign.center,
                    //                     style: TextStyle(
                    //                       fontFamily:
                    //                           VivahVriddhiAppTheme.fontName,
                    //                       fontWeight: FontWeight.w600,
                    //                       fontSize: 12,
                    //                       color: VivahVriddhiAppTheme.grey
                    //                           .withOpacity(0.5),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: <Widget>[
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Fat',
                    //                   style: TextStyle(
                    //                     fontFamily:
                    //                         VivahVriddhiAppTheme.fontName,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 16,
                    //                     letterSpacing: -0.2,
                    //                     color: VivahVriddhiAppTheme.darkText,
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(
                    //                       right: 0, top: 4),
                    //                   child: Container(
                    //                     height: 4,
                    //                     width: 70,
                    //                     decoration: BoxDecoration(
                    //                       color: HexColor('#F1B440')
                    //                           .withOpacity(0.2),
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(4.0)),
                    //                     ),
                    //                     child: Row(
                    //                       children: <Widget>[
                    //                         Container(
                    //                           width: ((70 / 2.5) *
                    //                               animationController!.value),
                    //                           height: 4,
                    //                           decoration: BoxDecoration(
                    //                             gradient:
                    //                                 LinearGradient(colors: [
                    //                               HexColor('#F1B440')
                    //                                   .withOpacity(0.1),
                    //                               HexColor('#F1B440'),
                    //                             ]),
                    //                             borderRadius: BorderRadius.all(
                    //                                 Radius.circular(4.0)),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 6),
                    //                   child: Text(
                    //                     '10g left',
                    //                     textAlign: TextAlign.center,
                    //                     style: TextStyle(
                    //                       fontFamily:
                    //                           VivahVriddhiAppTheme.fontName,
                    //                       fontWeight: FontWeight.w600,
                    //                       fontSize: 12,
                    //                       color: VivahVriddhiAppTheme.grey
                    //                           .withOpacity(0.5),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
