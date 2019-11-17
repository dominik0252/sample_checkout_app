# Sample basket checkout app

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate and seed the database:

```
$ rails db:migrate
$ rails db:seed
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```



* Author: [Dominik Vidusin](mailto:dominik.vidusin@gmail.com)
* Ruby version:   2.5.0
* Rails version:  5.1.7
* Weather forecast data is collected from [OpenWeatherMap](https://openweathermap.org/)
