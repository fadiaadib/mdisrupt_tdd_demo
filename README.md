# MDisrupt Testing Environment Demo:

## Concept of testing (unittest, widget tests and accessibility tests).

- Mock (dependencies)
- Call (functionality)
- Expect (result)
- Verify (calls and cheats)

## The Things Demo App

### Breakdown:

> The testing demo is a very high tech app that adds and retrieves `Things` from the `SharedPreferences`

1.  #### The Thing app! [go to Simulator]

    - This app has a single feature: managing things (add and retrieve things but no delete 🥺).
    - Uses the SharedPreferences for storage.

2.  #### Code structure: [go to code]

    > ## Code Structure
    >
    > - **Domain**: Usecases, Repo and Entities.
    > - **Data**: Model, Repo and Datasources.
    > - **Presentation**: Blocs, Pages and Widgets.

    - A single feature folder includes:
      - The domain.
      - The data.
      - The presentation.
      - Injection implementation.

### Unit testing:

> [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
>
> [mocktail](https://pub.dev/packages/mocktail) (not [mockito](https://pub.dev/packages/mockito))
>
> [bloc_test](https://pub.dev/packages/bloc_test)

1. What needs unit testing?

   - Domain:
     - Usecases: Are they correctly calling the Repo and getting the right results?
   - Data:
     - Models: Are they created correctly and do their serialization methods work correctly?
     - Repos: Are they calling the correct datasources and getting the right results?
     - Datasources: Are they calling the correct external library and behaving correctly according to the results?
   - Presentation:
     - Blocs: Are they emiting the correct states for the correct events?

2. How to create unittests for each subject? [go to code]

   - Mock the subject's dependencies (**mocktal**).
   - Create an instance of your subject.
   - Create your AAA tests (Arrange, Act and Assert).
   - Use Mocktail to arrange, and mocktail (verify) and flutter test (expect) to assert.
   - Group tests.
   - Run tests.

### Widget testing:

> [testWidget](https://docs.flutter.dev/cookbook/testing/widget/introduction)

#### How do we test the UI? [go to code]

- Mock any external dependencies (mocktal).
- Pump the widget.
- Add interactions.
- Create your AAA tests (Arrange, Act and Assert).

### Accesibility testing:

> [Guidlines](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility)
>
> **BUT** they make it quite simple!

#### How do we test for accessibility? [go to code]

- How to create an accesibility test for a widget.

## Dependency Injection (Optional Choice)

> [get_it](https://pub.dev/packages/get_it)
