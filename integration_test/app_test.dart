import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:music_app/presentation/widgets/tite_description_widget.dart';

final searchButton = find.byIcon(Icons.search);
final searchBar = find.byType(TextField);
final Finder backButton = find.byTooltip("Back").last;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const String appName = "Music App";
  const String searchFieldText = "Queens";
  const String searchFieldText1 = "Beatles";

  testWidgets('E2E TestCase', (tester) async {
    // Initialization app.
    app.main();

    //Triggers a frame after duration amount of time.
    await tester.pumpAndSettle();

    //Verifying the App name is properly displayed.
    expect(find.text("Music App"), findsOneWidget);
    await tester.pumpAndSettle();

    //Verifying the Search button is properly displayed.
    expect(find.byIcon(Icons.search), findsOneWidget);
    await tester.pumpAndSettle();

    //Verifying the correct text is displaying if no album is liked.
    expect(find.text('No Albums added yet'), findsOneWidget);
    await tester.pumpAndSettle();

    //Clicking on search Button on homePage.
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    //Verifying the elements on searchPage.
    expect(searchBar, findsOneWidget);
    expect(searchButton, findsOneWidget);
    expect(backButton, findsOneWidget);

    //Tapping on search bar.
    await tester.tap(searchBar);
    await tester.pumpAndSettle();

    //Clicking on search bar and entering the album/artist name.
    await tester.enterText(searchBar, searchFieldText);
    await tester.pumpAndSettle();

    //Verifying there is no element from homePage is visible.
    expect(find.byType(HomePage), findsNothing);
    await tester.pumpAndSettle();

    //Click on search button once album/artist name is added.
    //Way 1 to perform multiple task. (element declaration)
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    //Click on first element in the list of album/artist.
    //Way 2 to perform multiple task.  element declaration)
    await tester.tap(find.byKey(const Key('albumWidget')).first);
    await tester.pumpAndSettle();

    var likeButton = find.byIcon(Icons.favorite);
    //Click on first heart button of album/artist.
    await tester.tap(likeButton.first);
    await tester.pumpAndSettle();

    //Click on title of album/artist.
    await tester.tap(find.byKey(const Key('Albumtitle')).first);
    await tester.pumpAndSettle();

    //Verifying album title is visible.
    expect(find.byType(TitleDescriptionWidget), findsWidgets);
    await tester.pumpAndSettle();

    //Added for loop to go back on homePage to avoid Boilerplate code.
    for (int j = 0; j < 3; j++) {
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
    }
    //Verifying there is one element on homePage.
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pumpAndSettle();
  }); //E2E Test Ends.
}
