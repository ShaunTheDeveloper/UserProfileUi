import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  Locale locale = Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', '1'), // English
        Locale('fa', '98'), // Persion
      ],
      locale: locale,
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(locale.languageCode)
          : MyAppThemeConfig.light().getTheme(locale.languageCode),
      home: MyHomePage(
        onToggleTheme: () {
          setState(() {
            if (themeMode == ThemeMode.dark)
              themeMode = ThemeMode.light;
            else
              themeMode = ThemeMode.dark;
          });
        },
        onLanguageChange: (Language lan) {
          setState(() {
            locale = Locale(lan.name);
          });
        },
      ),
    );
  }
}
//

class MyHomePage extends StatefulWidget {
  final Function() onToggleTheme;
  final Function(Language lan) onLanguageChange;

  const MyHomePage(
      {super.key, required this.onToggleTheme, required this.onLanguageChange});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SkillType skillType = SkillType.photoshop;
  Language language = Language.en;

  void changeSkillTypeState(SkillType skillType) {
    setState(() {
      this.skillType = skillType;
    });
  }

  void languageUpdate(Language value) {
    widget.onLanguageChange(value);
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profile_title),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          SizedBox(width: 8),
          InkWell(
              onTap: widget.onToggleTheme,
              child: Icon(CupertinoIcons.ellipsis_vertical)),
          SizedBox(width: 4)
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(32),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/profile_image.png',
                    width: 64,
                    height: 64,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(localization.job),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location,
                            size: 18,
                          ),
                          SizedBox(width: 2),
                          Text(
                            localization.location,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Theme.of(context).primaryColor,
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(localization.summary),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 15, 32, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selectLanguage),
                  CupertinoSlidingSegmentedControl<Language>(
                      groupValue: language,
                      children: {
                        Language.en: Text(localization.englishLanguage),
                        Language.fa: Text(localization.persionLanguage)
                      },
                      onValueChanged: (value) => languageUpdate(value!))
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Skills", style: Theme.of(context).textTheme.bodyLarge),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                  )
                ],
              ),
            ),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Skill(
                    type: SkillType.photoshop,
                    title: SkillType.photoshop.name,
                    imagePaht: 'assets/images/app_icon_01.png',
                    shado: Colors.purple,
                    isActive: this.skillType == SkillType.photoshop,
                    onTap: () {
                      changeSkillTypeState(SkillType.photoshop);
                    },
                  ),
                  Skill(
                      type: SkillType.xd,
                      title: "Adobe XD",
                      imagePaht: 'assets/images/app_icon_05.png',
                      shado: Colors.blue,
                      isActive: this.skillType == SkillType.xd,
                      onTap: () {
                        changeSkillTypeState(SkillType.xd);
                      }),
                  Skill(
                    type: SkillType.lightRoom,
                    title: "Lightroom",
                    imagePaht: 'assets/images/app_icon_02.png',
                    shado: Colors.blue,
                    isActive: this.skillType == SkillType.lightRoom,
                    onTap: () {
                      changeSkillTypeState(SkillType.lightRoom);
                    },
                  ),
                  Skill(
                      type: SkillType.illustrator,
                      title: "Illustrator",
                      imagePaht: 'assets/images/app_icon_04.png',
                      shado: Colors.blue,
                      isActive: this.skillType == SkillType.illustrator,
                      onTap: () {
                        changeSkillTypeState(SkillType.illustrator);
                      }),
                  Skill(
                      type: SkillType.afterEffect,
                      title: "After Effect",
                      imagePaht: 'assets/images/app_icon_03.png',
                      shado: Colors.blue,
                      isActive: this.skillType == SkillType.afterEffect,
                      onTap: () {
                        changeSkillTypeState(SkillType.afterEffect);
                      })
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 15, 32, 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personal Information",
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(CupertinoIcons.at)),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password)),
                    )
                  ]),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 14, 32, 15),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, child: Text('Save'))),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final SkillType type;
  final String title;
  final String imagePaht;
  final Color shado;
  final bool isActive;
  final Function() onTap;

  const Skill(
      {super.key,
      required this.type,
      required this.title,
      required this.imagePaht,
      required this.shado,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: this.isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(12))
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(imagePaht, width: 50, height: 50),
              decoration: this.isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: this.shado.withOpacity(0.5), blurRadius: 10)
                    ])
                  : null,
            ),
            SizedBox(height: 8),
            Text(title)
          ],
        ),
      ),
    );
  }
}

class MyAppThemeConfig {
  final String primaryFontFarsi = 'IranSans';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900,
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      dividerColor: surfaceColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          backgroundColor: appBarColor, surfaceTintColor: primaryTextColor),
      textTheme: languageCode == 'en' ? englishPrimaryFont : farsiPrimaryFont,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: surfaceColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor))),
      useMaterial3: true,
    );
  }

  TextTheme get englishPrimaryFont => GoogleFonts.latoTextTheme(TextTheme(
        bodySmall: TextStyle(fontSize: 11),
        bodyMedium: TextStyle(fontSize: 13, color: secondaryTextColor),
        bodyLarge: TextStyle(fontSize: 15, color: primaryTextColor),
        titleLarge:
            TextStyle(fontWeight: FontWeight.w900, color: primaryTextColor),
        titleSmall: TextStyle(fontSize: 16, color: secondaryTextColor),
      ));

  TextTheme get farsiPrimaryFont => TextTheme(
        bodySmall: TextStyle(fontSize: 11, fontFamily: primaryFontFarsi),
        bodyMedium: TextStyle(
            fontSize: 13,
            color: secondaryTextColor,
            fontFamily: primaryFontFarsi),
        bodyLarge: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: primaryFontFarsi),
        titleLarge: TextStyle(
            fontWeight: FontWeight.w900,
            color: primaryTextColor,
            fontFamily: primaryFontFarsi),
        titleSmall: TextStyle(
            fontSize: 16,
            color: secondaryTextColor,
            fontFamily: primaryFontFarsi),
      );
}

enum SkillType { photoshop, xd, illustrator, afterEffect, lightRoom }

enum Language { en, fa }
