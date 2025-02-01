# Foody

A modern, minimalist Recipe blog application built with Flutter and GraphQL. Foody provides a seamless experience for Posting your favorite recipes with role-based access control and persistent authentication.

## Features

### Authentication & Authorization
- Secure login and registration system
- Role-based access control (Simple User &  Admin)
- Persistent login using SharedPreferences
- Protected routes based on user roles

### User Interface
- Clean, minimalist design language
- Responsive layouts for various screen sizes
- Custom widgets for consistent UI elements
- Smooth animations and transitions
- Dark mode support

### Technical Implementation
- GraphQL integration for efficient data fetching
- State management using Provider
- Custom theme implementation
- Modular architecture for better maintainability

## Project Structure

```
├── graphql_backend/  # Node.js + Express + GraphQL server
└── foody/            # Flutter mobile application
```

## Backend

The backend is built with Node.js and Express.js, implementing a GraphQL API using Apollo Server.

### Tech Stack

- Node.js
- Express.js
- MongoDB (Database)
- GraphQL
- Apollo Server
- Nodemon (Development)

### Setup

1. Navigate to the backend directory:
```bash
cd graphql_backend
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file with your MongoDB connection string:
```
MONGO_CONNECTION_STRING=your-mongo-uri
JWT_SECRET=your-secret
PORT=your-available-port
```

4. Start the development server:
```bash
npm start
```

The GraphQL playground will be available at `http://localhost:<port>/graphql`

## Flutter App

## Getting Started

### Prerequisites
- Flutter SDK (2.5.0 or higher)
- Dart SDK (2.14.0 or higher)
- Android Studio / VS Code with Flutter extensions
- GraphQL server endpoint

### Installation

1. Clone the repository
```bash
git clone https://github.com/YassineElkefi/Foody
cd foody
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure environment variables
Create a `.env` file in the root directory and add:
```
GRAPHQL_ENDPOINT=your_graphql_endpoint
```

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── config/
│   │   └── graphql_config.dart
│   ├── constants/
│   ├── providers/
│   ├── services/
│   └── utils/
│   
├── data/
│   └── models/
│
│
├── features/
│   ├── admin/
│   ├── auth/
│   └── home/
├── shared/
│   └── widgets/
├── theme.dart
└── main.dart
```

## Authentication Flow

The app implements a role-based authentication system with the following roles:
- User: Browse Recipes, Add his own recipes, Check his profile
- Admin: Browse users

## Custom Widgets

The app includes several custom widgets for consistent UI:
- Custom FilledButtons
- Custom Cards
- Custom TextStyles

## State Management

Provider is used for state management with the following main providers:
- AuthProvider: Handles authentication state

## GraphQL Integration

The app uses GraphQL for data fetching with the following features:
- Queries for menu items, orders, and user data
- Mutations for placing orders and updating status
- Subscriptions for real-time order updates


## Copyright ©

This project is made by Yassine Elkefi for the sake of training