# Auth_UI

This project is a Flutter-based authentication UI that connects to a PHP + MySQL backend.  

## Project Structure
- `lib/` - Flutter frontend code
- `flutter_api/` - PHP backend code (to be placed in XAMPP's `htdocs`)

## Prerequisites
- Flutter SDK (latest stable version)
- Dart (comes with Flutter)
- XAMPP (Apache + MySQL)
- Git

### Important Note on API Endpoints When setting up the Flutter app, make sure to replace the placeholder IP addresses in all `final String` URLs (e.g., login, register, dashboard) with **your own device’s IPv4 address**.
This ensures the app can properly connect to your local PHP + MySQL backend. 
Example: 
```dart
final String _usersUrl = 'http://192.168.1.160/flutter_api/get_users.php'; // Replace with your device's IPv4 address
```

## Backend Setup (PHP + MySQL)
```markdown
1. Copy the `flutter_api/` folder into your XAMPP `htdocs` directory.
   Example: `C:/xampp/htdocs/flutter_api/`
2. Start Apache and MySQL from the XAMPP Control Panel.
3. Run the program using your chosen IDE and perform testing

