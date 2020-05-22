# Contactlist

A Flutter application working with API to handle data in background created using Django Rest Framework.


## Build With
* [Flutter](https://pub.dev/packages/backdrop) -  Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.
* [Django Rest Framework](https://www.django-rest-framework.org/) - Django REST framework is a powerful and flexible toolkit for building Web APIs.
* [backdrop](https://pub.dev/packages/backdrop) -  A library to build Scaffold in Flutter.
* [google_fonts](https://pub.dev/packages/google_fonts) - The *google_fonts* package for Flutter allows you to easily use any of the 977 fonts (and their variants) from [fonts.google.com](https://fonts.google.com/) in your Flutter app.



[![N|Solid](https://flutter.dev/assets/flutter-lockup-c13da9c9303e26b8d5fc208d2a1fa20c1ef47eb021ecadf27046dea04c0cebf6.png)](https://flutter.dev/)  

[![](https://www.django-rest-framework.org/img/logo.png)](https://www.django-rest-framework.org/)


## Requirements
* Python
* Django
* Django Rest Framework
* Flutter

## Structure
In a RESTful API, endpoints (URLs) define the structure of the API and how end users access data from our application using the HTTP methods - GET, POST, PUT, DELETE. Endpoints should be logically organized around collections and elements, both of which are resources.
|Endpoint   |  HTTP Method |  CRUD Method | Result  |   
|---|---|---|---|
| ```viewset/details/```  |  GET | READ  | Get all namecards  |   
|  ```viewset/details/``` | POST  | CREATE  | Create a new namecard  |   
|  ```viewset/details/id``` |  GET | READ  | Get a specific namecard |
|  ```viewset/details/id``` |  PUT | UPDATE  | Update a specific namecard 
|  ```viewset/details/id``` |  Delete | DELETE  | Delete a specific namecard 

### Installation


To install the dependencies and start the server make sure you have virtualenv installed
First create a virtual environment and enter 
```sh
$ git clone git@github.com:rohitsk14/flutter-drf-project.git
$ cd flutter-drf-project\rest_api
$ pip install -r requirements.txt
$ python manage.py runserver
```
After starting the server, to run the app enter following in the terminal
```sh
$ cd FlatApp-Flutter/
```
Make sure you have an Android emulator installed and running.
Run the following command in your terminal.
```sh
$ flutter run
```




## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

 
