# [e-learn-turvitan](http://e-learn.turvitan.km.ua) platform

###### Best udemy clone on the market. Set up your online school in minutes!

### [Certificate of completion course](https://www.udemy.com/certificate/UC-a19cfc62-5e67-435c-b59e-6530104fb9e3/?deal_code=&utm_source=aff-campaign&utm_medium=udemyads&utm_term=Homepage&utm_content=Textlink&utm_campaign=Admitad-default&admitad_uid=9a68e2c3021f8c16cd5667aa8e19e4d8&publisher_id=606171&website_id=701387)

### [Test application on Heroku](https://e-learn-turvitan.herokuapp.com)
#### test as admin
* email: teacher@example.com
* password: 123456

### Entity-Relationship Diagram

[![N|Solid](https://i.imgur.com/IIWWYxW.png)](e-learn-turvitan.herokuapp.com)

### Installation Requirements
* ruby v 2.7.2
* rails 6.0.3.4
* postgresql database
* yarn

### Connected services required
* AWS S3 - file storage ** in production **
* google analytics code ** in production **
* google recaptcha API for signing up ** in production **
* google oauth API ** in development and production **
* github oauth API ** in development and production **
* facebook oauth API ** in development and production **

### Installation the app

1. Create app
```
git clone https://github.com/Turzhanskyi/e-learning-platform.git
cd e-learning-platform
bundle
yarn

sudo apt-get install graphviz
sudo apt install imagemagick
```
2. IMPORTANT Set up your secret credentials, otherwise you will not be able to run the app:

Go to **config** folder and delete the file `credentials.yml.enc`
```
EDITOR='nano' rails credentials:edit
```
and inside the file:
```
awss3:
  access_key_id: YOUR_CODE_FOR_S3_STORAGE
  secret_access_key: YOUR_CODE_FOR_S3_STORAGE
google_analytics: YOUR_CODE_FOR_GOOGLE_ANALYTICS
recaptcha:
  site_key: YOUR_CODE_FOR_RECAPTCHA
  secret_key: YOUR_CODE_FOR_RECAPTCHA
google_oauth2:
  client_id: YOUR_CODE_FOR_OAUTH
  client_secret: YOUR_CODE_FOR_OAUTH
github:
  client: YOUR_CODE_FOR_OAUTH
  secret: YOUR_CODE_FOR_OAUTH
facebook:
  client: YOUR_CODE_FOR_OAUTH
  secret: YOUR_CODE_FOR_OAUTH
stripe:
  publishable: YOUR_STRIPE_PUBLISHABLE
  secret: YOUR_STRIPE_SECRET
```
3. Run the migrations
```
rails db:create
rails db:migrate
rails db:seed
```
4. Configure your development environment in config/environments/development.rb
5. Start the server
```
rails s
```

### For production environments
```
heroku create
heroku rename *your-app-name*
heroku git:remote -a *your-app-name*
git push heroku master
heroku run rake db:migrate
heroku addons:create sendgrid:starter
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
```
