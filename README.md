# Ruby on Rails  
  
Rails is simple, but the knowledge builds up quickly. We're going to
be going over some projects. In class, we'll be covering a project
called "[Awesome Answers](http://awesome-qa.herokuapp.com/)". Please try to follow along with this, as we
will be continuing from where we left off, on a daily basis.  
  
There will also be a project for a "Project Management Tool" that will
be applying the principles learned through exercises with "Awesome
Answers."  
  
**Rails**
  * saves you a lot of time
  * has a large community
  * has many gems
  * is a well known framework  
  
Rails was created by David Heinemeir Hansson
([DHH](https://twitter.com/dhh)) of [37
Signals](https://37signals.com/). Github uses rails, groupon,
shopify, yellow pages, Basecamp, twitter (at first).  
  
Rails is very opinionated. The core team made decisions to do
things a certain way, and so there are many conventions in rails.
Rails is a gem, just like Sinatra.  
  
Let's start by installing rails, if you haven't already.  
```bash
gem install rails
# or
gem install rails --no-rdoc
```  
If you specify a gem version with `~>`, it will install the latest
stable version, i.e. in the case of rails 4.0.4, it would install up
to 4.0.9, but not 4.1.  
```bash
gem 'rails', '~> 4.0.4'
```  
Rails comes with many parts, including actionmailer, so we no
longer need the Pony gem, for example.  
  
Create a new rails project called "awesome_answers", using a
postgresql database.  
```bash
rails new awesome_answers -d postgresql
```  
cd into the directory rails created called "awesome_answers" and open
it up in your favorite text editor.  
```bash
cd awesome_answers
subl .
```  
  
## Files and Structure
```bash
config.ru           # is where we tell the server to require our app.
.gitignore          # here we can list files we do not want git to
track, e.g. config/database.yml
config/database.yml # if you are using postgres, or any database
other than sqlite, you will need to specify your username
```  
  
**app**: This organizes your application components. It's got
subdirectories that hold the view (views and helpers), controller
(controllers), and the backend business logic (models).

**app/controllers**: The controllers subdirectory is where Rails
looks to find controller classes. A controller handles a web
request from the user.

**app/helpers**: The helpers subdirectory holds any helper classes used
to assist the model, view, and controller classes. This helps to keep
the model, view, and controller code small, focused, and uncluttered.

**app/models**: The models subdirectory holds the classes that
model and wrap the data stored in our application's database. In most
frameworks, this part of the application can grow pretty messy,
tedious, verbose, and error-prone. Rails makes it dead simple!

**app/view**: The views subdirectory holds the display templates to fill
in with data from our application, convert to HTML, and return to the
user's browser.

**app/view/layouts**: Holds the template files for layouts to be used
with views. This models the common header/footer method of wrapping
views. In your views, define a layout using the `layout :default` and
create a file named default.rhtml. Inside default.rhtml, call `<%
yield %>` to render the view using this layout.  
ref:
[tutorialspoint](http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm)  
  
## database.yml
```ruby
# config/database.yml
development:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_development
  pool: 5
  username: my_mac_username             # in terminal type whoami if
you wish to see your Mac username.
  password:

test:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_test
  pool: 5
  username: my_mac_username           
  password:

# production:                           # because we will deploy to
Heroku, which sets its own database, we don't need this
#   adapter: postgresql
#   encoding: unicode
#   database: awesome_answers_production
#   pool: 5
#   username: my_mac_username
#   password:
```  
Make sure you are in your app's directory "awesome_answers" and run the
command `rails s` or `rails server` in the terminal. This should
start up your rails server, and give a message like this  
```bash
=> Booting WEBrick
=> Rails 4.0.2 application starting in development on
http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2014-03-24 10:09:23] INFO  WEBrick 1.3.1
[2014-03-24 10:09:23] INFO  ruby 2.1.0 (2013-12-25)
[x86_64-darwin12.0]
[2014-03-24 10:09:23] INFO  WEBrick::HTTPServer#start: pid=90355
port=3000
```  
If you get an error stating the databse does not exist, run `rake
db:create`.  
  
## MVC
MVC resources: [video](https://www.youtube.com/watch?v=3mQjtk2YDkM) |
[Coding
Horror](http://blog.codinghorror.com/understanding-model-view-controller/)
| [Better
Explained](http://betterexplained.com/articles/intermediate-rails-understanding-models-views-and-controllers/)  
In Sinatra, we had our routes in our controllers, when we did
something like  
```ruby
get "/" do
  @tasks = Task.all         # Task is a model
  erb :index                # index.erb is a view
end
```  
In Rails, we have a separate file for routes called `routes.rb`  

**Model**  
The model represents the information and the data from the
database. It is as independent from the database as possible (Rails
comes with its own O/R-Mapper, allowing you to change the database that
feeds the application but not the application itself). The model also
does the validation of the data before it gets into the database. Most
of the time you will find a table in the database and an according
model in your application.  
  
**View**  
The view is the presentation layer for your application. The view
layer is responsible for rendering your models into one or more
formats, such as XHTML, XML, or even Javascript. Rails supports
arbitrary text rendering and thus all text formats, but also
includes explicit support for Javascript and XML. Inside the view you
will find (most of the time) HTML with embedded Ruby code. In
Rails, views are implemented using ERb by default.  
  
**Controller**  
The controller connects the model with the view. In Rails,
controllers are implemented as ActionController classes. The
controller knows how to process the data that comes from the model and
how to pass it onto the view. The controller should not include any
database related actions (such as modifying data before it gets
saved inside the database). This should be handled in the proper
model.  
  
**Helper**  
When you have code that you use frequently in your views or that is too
big/messy to put inside of a view, you can define a method for it
inside of a helper. All methods defined in the helpers are
automatically usable in the views.  
  
ref: [Rails
Wiki](http://en.wikibooks.org/wiki/Ruby_on_Rails/Getting_Started/Model-View-Controller)  
  
## Convention over Configuration  
Rails goes with the motto "Convention over Configuration". So,
instead of having to spend a lot of time configuring options, we
follow a set of conventions.  
For example, in Sinatra, we might have something like  
```ruby
# app.rb
get "/" do
  @task = Task.all
  erb :index          # Here we have to state erb :index to render this
view
end  

# Rails 
def index             # In Rails, we just define a method for each view
in its controller
end
```  
  
## Gemfile & Bundler
Our Gemfile stores all the gems we use in our application.  
```ruby
# Gemfile

source 'https://rubygems.org'         # this is currently (and for the
foreseeable future) the main source for rubygems

gem 'rails', '4.0.2'                  # this uses the specfic rails
version '4.0.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'          # this will use sass-rails up to
version 4.0.9
gem 'uglifier', '>= 1.3.0'            # this will use an uglifier
version greater than or equal to 1.3.0
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

```  
Add thin to your Gemfile  
```ruby
# Gemfile

source 'https://rubygems.org'         # this is currently (and for the
foreseeable future) the main source for rubygems

gem 'rails', '4.0.2'                  # this uses the specfic rails
version '4.0.2'
gem 'pg'
gem 'thin'                            # add thin instead of webrick

gem 'sass-rails', '~> 4.0.0'          # this will use sass-rails up to
version 4.0.9
gem 'uglifier', '>= 1.3.0'            # this will use an uglifier
version greater than or equal to 1.3.0
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do          # require gems for
development and test environments
  gem 'debugger'
  gem 'rspec-rails'
end

```  
Then run `bundle install` to update your app to use thin, and make sure
to restart your server  
```bash
ctrl-c
rails s
```  
## REST  
Routes in rails use [RESTful
architecture](http://en.wikipedia.org/wiki/Representational_state_transfer}
(Representational state transfer). Let's look at what this means.  
  
Inside your app's directory, in the terminal type `rails generate
controller home`. Then, open up your routes.rb file.  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/about_us" => "home#about"         # we add get, then give a
path, followed a hashrocket. We then reference
                                          # 'home' which is a
controller, and about (method in the home controller)
end

```  
get is an HTTP verb.
  * GET
  * POST
  * PATCH/PUT
  * DELETE  
  
Add a method to your home_controller called about.  

```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def about
    render text: "Welcome"
  end
  
end
```  
Here we are just rendering the text "Welcome". However, by default, the
method name in the controller will look for a view.erb file. So,
let's set one up. Create a page called about.erb in your
app/views/[controller] directory.  
```ruby
# app/views/home/about.erb

<h1>Hello!</h1>

```  
Now, remove the line `render text: "Welcome"` from your
home_controller.  
```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def about
  end
  
end
```  
Let's add an FAQ.  
```ruby
# config/routes.rb
get "/faq" => "home#faq"          # add this line to your routes file
```  
define a method in your home controller.  
```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController

  def about
  end
  
  def faq
  end
  
end
```  
Create an faq.erb file in your views directory  
```ruby
# app/views/home/faq.erb
<h1>FAQ</h1>
```  
What's a controller?  
It's a class  
```ruby
app/controllers/home_controller.rb
class HomeController < ApplicationController              # our home
contoller inherits from ApplicationController.

  def about
  end
  
  def faq
  end

end
```  
application_controller.rb
```ruby
app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
```  
`protect_from_forgery` makes it so you can't easily put something or
post something, without an authorization token. Basically by having this
in the application_controller, all my controllers have this as long as
they *inherit from this controller*.  
  
```ruby
# config/environments/production.rb
AwesomeAnswers::Application.configure do

  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your
application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching
reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will
already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is
missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your
assets.
  config.assets.version = '1.0'

  # Force all access to the app over SSL, use
Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true  # Here we can force_ssl

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an
asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in
app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery
errors.
  # Set this to true and configure the email server for immediate
delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall
back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not
suppressed.
  config.log_formatter = ::Logger::Formatter.new
end
```  
If I want to create a special section in my website for help, what
should I do? Where should I start? (in terminal in the directory of your
application)
```bash
rails generate controller help  

#############################
#### To see the options available to generate, try just rails generate
#############################

rails generate

Rails:
  assets
  controller
  generator
  helper
  integration_test
  jbuilder
  mailer
  migration
  model
  resource
  scaffold
  scaffold_controller
  task

Coffee:
  coffee:assets

Jquery:
  jquery:install

Js:
  js:assets

TestUnit:
  test_unit:plugin

```   

Then add some routes to the routes.rb  
```ruby
# config/routes.rb
# ...
  get "/help" => "help#index"
  
#...
```  

Add an index method to the help controller
```ruby
class HelpController < ApplicationContoller
  
  def index
  end

end  
```  
  
Add an index.erb inside a help directory to the views diretory  
```ruby
app/views/help/index.erb
<h1>Welcome to the help section</h1>
```   
  
We can access all the routes available in our app if we go to
[localhost:3000/rails/info/routes](http://localhost:3000/rails/info/routes)  
  
We can see in our routes that rails automatically generates
'helpers' for us. Rather than /about_us, we now have a rails method we
can use to access this route through our app called `about_us_path`.  
  
We use this to create links, for example add a navigation section
```ruby
# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>AwesomeAnswers</title>
  <%= stylesheet_link_tag    "application", media: "all",
"data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" =>
true %>
  <%= csrf_meta_tags %>
</head>
<body>

# Add a navigation section here

  <%= link_to "About Us", about_us_path, class: "btn btn-primary", id:
"about" %> | 
  <%= link_to "FAQ", faq_path %> | 
  <%= link_to "Help", help_path %>

<%= yield %>

</body>
</html>

```  
## Rails Resources  

If I have a resource called post, it will be a model Post.rb, and a
controller posts_controller.rb. Models are given singular names, and
controllers are given the plural of the model, by convention, and this
is how rails works.    
Let's start by creating a controller: `rails generate controller
questions`.  
  
To show all the questions, we can define a method called index in the
questions_controller.  
```ruby
class QuestionsController < ApplicationController

  def index
  end
  
end
```  
And add a route 
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/" => "home#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions" => "questions#index"

end
```  
Add an index.html.erb page to the view  
```ruby
# app/views/qustion/index.html.erb
<h1>Listing All Questions</h1>


```  
If I want to create a question, I need to define a method create. What
should the route for this be? `post "/questions => "questions#index"` 
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/" => "home#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions" => "questions#index"
  post "/questions" => "questions#index"

end
```  
If  want to show a specific question, what should I do? That's
right! `get "/questions/:id" => "questions#show"`  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  get "/" => "home#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions" => "questions#index"
  post "/questions => "questions#index"
  get "/questions/:id" => "questions#show"

end
```   
And of course, then define the `show` method in the
questions_controller.  
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
  end

  def create
  end
  
  def show
    render text: "The id is: #{params[:id]}"     #we can get the
question based on it's ID. This is available through params
  end

end
```  
To edit, update, and destroy a question, we can add the according
methods and routes.  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  root "questions#index"        # specify the root path just like
                                # get "/" => "questions#index"

  get "/about_us" => "home#about"

  get "/faq" => "home#faq"

  get "/help" => "help#index"

  get "/questions"          => "questions#index"
  post "/questions"         => "questions#create"
  get "/questions/:id"      => "questions#show"
  get "/questions/:id/edit" => "questions#edit"
  match "/questions/:id"    => "questions#update", via: [:put,
:patch]
  delete "/questions/:id"   => "questions#destroy"
  
  
  ### Note, we can create all these routes by adding the simple line
  resources :questions
  
  ### to limit the routes available to questions, we can add only
  resources :questions, only: [:index, :new, :create]

end
```   

Methods
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
  end

  def create
    render text: "Create a question"
  end

  def show
    render text: "The id is: #{params[:id]}"
  end

  def edit
    render text: "Editing question: #{params[:id]}"
  end

  def new
    render text: "A new question"
  end

end
```  
If I want to do something like vote on a question, I can add a path to
the routes.rb such as:  
```ruby
# config/routes.rb
  resources :questions do 
    post :vote_up, on: :member
  end
```  
  
This will create the route `vote_up_question_path POST
/questions/:id/vote_up(.:formattert) questions#vote_up`. We are
voting up on member, because we are selecting a particular member in a
collection. If want to search a collection of questions, I would add
`post :search, on: :collection` to the routes resource. A
collection doesn't require an id, whereas a member does.  
```ruby
# config/routes.rb
  resources :questions do 
    post :vote_up, on: :member
    post :search, on: :collection
  end
```   
This creates the route `search_questions_path POST
/questions/search(.:format) questions#search`.  If we want to have a
series of methodhods on a member or collection, he's the syncax.  
```ruby
# config/routes.rb
  resources :questions, only: [:index, :create, :show] do     # in
contrast to only, we could use except: [:update, :create], etc.
    member do 
      post :vote_up
      post :vote_down
    end
    post :search, on: :collection
  end
```
# Active Record  
  
**What is a model?**  
When I try to model my app into objects, I used these classes to
represent the different entities in my application. When we want to map
the database, we use an ORM. We used DataMapper in Sinatra. In
Rails, we use ActiveRecord.  
  
Our Question and Answer app is going to have two models: Question and
Answer.  
  
What kind of information do I need in the Question model?  
  * id
  * title
  * description   

And in the Answer model?  
  * id
  * body  

Let's start by creating the Question model. Active Record's
approach to things is a little different from DataMapper. The way to
generate a model is using `rails generate [model-name]`. For our
controllers, we used plural names, however for models we use
singular. The table will be plural. So, if we make a model called
'Task' the database table will be 'tasks'. Rails does this for us.  
  
We can add the attributes to our model in the command line, like so  
```ruby
rails generate model question title:string description:text
```  
***note***: I do not have to explicitly say, I need an id. One will be
created automatically.  
***noteII***: The opposite of 'generate' is destroy. So if I wanted to
destroy this model, I would use `rails destroy model question`   
  
Open up db/migrate/[migration-file]  
```ruby
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
```  
  
Before running a `rake db:migrate` we could add different fields to the
migration file, and this will create them when it runs the
migration. For eample:  
```ruby
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      # t.text :description, default: "no description"
      t.text :description
      t.integer :view_count             # add a view count field

      t.timestamps
    end
    add_index :questions, :title        # adding an index speeds up
queries
  end
end
```  
We can put validations in our app for what data is stored in the
database. Some teams may have server-side validation as well.  
  
Run `rake db:migrate` to migrate. This will also create a db/schema.rb
file which shows the table structure for the database. Some more
[Active Record
migration](http://guides.rubyonrails.org/migrations.html) commands
`rake db:create`, `rake db:migrate`, `rake db:rollback`, `rake
db:reset`, `rake db:migrate:reset`.  
  
```ruby
db:create           # creates the database for the current env
db:create:all       # creates the databases for all envs
db:drop             # drops the database for the current env
db:drop:all         # drops the databases for all envs
db:migrate          # runs migrations for the current env that have not
run yet
db:migrate:up       # runs one specific migration
db:migrate:down     # rolls back one specific migration
db:migrate:status   # shows current migration status
db:migrate:rollback # rolls back the last migration
db:forward          # advances the current schema version to the next
one
db:seed             # (only) runs the db/seed.rb file
db:schema:load      # loads the schema into the current env's database
db:schema:dump      # dumps the current env's schema (and seems to
create the db as well)

db:setup            # runs db:schema:load, db:seed

db:reset            # runs db:drop db:setup
db:migrate:redo     # runs (db:migrate:down db:migrate:up) or
(db:migrate:rollback db:migrate:migrate) depending on the specified
migration
db:migrate:reset    # runs db:drop db:create db:migrate
```  
  
To add a migration that adds something to a table, you can do
something like  
```ruby
rails generate migration add_like_count_to_questions
```  
Open up your migration file, and add a column  
```ruby
class AddLikeCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :like_count, :integer
  end
end
```  
Add a migration to remove like_count from question `rails generate
migration remove_like_count_from_questions`  
Open up the migration and add a line to remove the column  
```ruby
class RemoveLikeCountFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :like_count, :integer
  end
end
```  
***Note***: If you just made a mistake, you can rollback, make the fix,
and delete that migration. However, if you are working on an app that
is in production, or working with a team, you always want to fix
forward, ie: migrate to add or remove columns, etc.  
  
## Rails Console  
To start the rails console, you can do `rails c` or `rails
console`. This is similar to irb, but you use it while in your
app's directory, and it has access to your rails app.  
  
Let's hope into rails console, and create a new question.  
```bash
rails c  
q = Question.new
=> #<Question id: nil, title: nil, description: nil, created_at: nil,
updated_at: nil>

# add title, and description
q.title = "My first question title from console."
q.description = "Here is a fine description of this question that I am
apparently not asking."
q
 => #<Question id: nil, title: "My first question title from
console.", description: "Here is a fine description of this
question that I ...", created_at: nil, updated_at: nil>
```  
To see if an object has gone into the database yet or not, you can use
the `persisted?` method. try `q.persisted?`. To save into the
databse, run `q.save`. Then check what the output of `q` is.  
```bash
q.save
q
 => #<Question id: 1, title: "My first question title from console.",
description: "Here is a fine description of this question that I ...",
created_at: "2014-03-25 17:16:46", updated_at: "2014-03-25 17:16:46">
 ```  
 
 Now, if we add some information to it, and save it again, our
`created_at` and `updated_at` will be different.  
 ```bash
 q.description = "What is the output of the question now?"
 q.save
 q
  => #<Question id: 1, title: "My first question title from console.",
description: "What is the output of the question now?", created_at:
"2014-03-25 17:16:46", updated_at: "2014-03-25 17:18:39">
```  
We can also pass in a has of parameters when called Question.new  
```bash
q2 = Question.new(title: "Another question for you", description: "Do
I have butterflies in my stomach all the time, because I'm super
excited about everything, or because the world is constantly falling?")
q2.save
q2
 => #<Question id: 2, title: "Another question for you",
description: "Do I have butterflies in my stomach all the time, b...",
created_at: "2014-03-25 17:20:27", updated_at: "2014-03-25 17:20:27">
 ```   
To create without doing `.new` and `.save`, we can use `.create`  

```bash
Question.create(title: "I have a question.", description: "How many
times have you given an egg to a raccoon?")
```  
## Add data validation  
Open up the question model and add `validates_presence_of :title`  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base

  validates_presence_of :title
  
end
```  
Then try saving a question in rails c without a title.  
```rake
# in rails console
reload!
q = Question.new
q.save
   (0.3ms)  BEGIN
[deprecated] I18n.enforce_available_locales will default to true in the
future. If you really want to skip validation of your locale you can
set I18n.enforce_available_locales = false to avoid this message.
   (0.4ms)  ROLLBACK
 => false 


# then check the errors!
q.errors
 => #<ActiveModel::Errors:0x000001022ebbb8 @base=#<Question id: nil,
title: nil, description: nil, created_at: nil, updated_at: nil>,
@messages={:title=>["can't be blank"]}> 
```  
[Validation
reference](http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html)  
  
Now add validation for the title to be unique using an alternative
syntax that allows for more attributes.  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base
 
  # validates_presence_of :title
  validates :title, presence: true, uniqueness: true
  
  validates_presence_of :description, message: "must be present"
  
end
```   
To update the attributes of a record in the database, use
`update_attributes`  
```bash
q.update_attributes(title: "updated title", description: "some new
description")
```  
Some other class methods  
```bash
Question.first
Question.last
Question.all
# Question.destroy_all        # will delete all records
Question.find_by_title "abc"
```  
To have your data records display nicely in the rails console, you can
use the gem hirb. Since you only need it for development, add it to a
group in your Gemfile  
```ruby
# Gemfile
#...

group :development do
  gem 'hirb'
  gem 'interactive_editor'
  gem 'awesome_print'
end

#...
```  
After adding to your Gemfile, do a `bundle install` in the
terminal, then in `rails c` do `Hirb.enable`. Add the following to your
.irbrc dotfile. This will require and enable 'hirb' when irb (or rails
c) loads, and if not, it will give an error.  
```ruby
# ~/.irbrc 

#...

begin
  require 'hirb'
  Hirb.enable
rescue LoadError => err
  warn "Couldn't load hirb: #{err}"
end

#...

```  
Try some more class methods  
```bash
Question.select(:id, :title, :description)
Question.select(:id, :title, :description).limit(2)
Question.select(:id, :title, :description).offset(2)
```  
## Basic Queries  
Queries are, in a large part, based on the `WHERE` statment.  
Here are some examples  
```bash
Question.where.not(title: "abc")                # will return all
questions where the title is not equal to "abc"
Question.where(["title like ?", "%fas%"])       # I pass in an array
to the WHERE. The first argument is the query string.
Question.where(["description like ?", "%fas%"])

# to find all records where title or description contains a string
Question.where(["title like ? OR description like ?", "%fas%",
"%fas%"])

Question.where(["title like ? OR description like ?", "%title%",
"%what%"]).where(["created_at > ?", 10.days.ago])

Question.order("title ASC")
Question.order("title DESC")
```   
Adding limits to the model, using
[scopes](http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html#method-i-scope)  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base

  #validates_presence_of :title
  validates :title, presence: {message: "must be there"}  ,
uniqueness: true

  validates_presence_of :description, message: "must be present"
  
  # a default scope will be used for al queries
  default_scope order("title ASC")

  # "->" is shorthand for lambda
  # to pass in a variable, use "->(x)"
  # scope :recent_tn, lambda { order("created_at DESC").limit(10) }
  
  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }
  
  # this can be shorted by writing a scope
  def self.recent_ten
    order("created_at DESC").limit(10)
  end
  
  def self.recent(x)
    order("created_at DESC").limit(x)
  end
  
end
```  
## Callbacks  
Callbacks are widely used in Active Record (see: [Active Record
Callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)).
Sometimes I want to do an operation on something before I add it to a
record, and I want to do it to every record in the databse. Let's say I
want to capitalize the title before i save it in the database, I can
do something like this:  
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base

  #validates_presence_of :title
  validates :title, presence: {message: "must be there"}  ,
uniqueness: true

  validates_presence_of :description, message: "must be present"
  
  # a default scope will be used for al queries
  default_scope order("title ASC")

  # "->" is shorthand for lambda
  # to pass in a variable, use "->(x)"
  # scope :recent_tn, lambda { order("created_at DESC").limit(10) }
  
  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }
  
  # this can be shorted by writing a scope
  def self.recent_ten
    order("created_at DESC").limit(10)
  end
  
  def self.recent(x)
    order("created_at DESC").limit(x)
  end
  
  before_save :capitalize_title             # call the before_save
action :capitalize_title
  
  private
  
  def capitalize_title                 # create a method to
capitalize the title before saving
    self.title.capitalize!
  end
  
end
```  
# Building a Rails CRUD  
  
For the questions index page create an instance variable with all
questions.  

```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def create
    render text: "Create a question"
  end

  def show
  end

  def edit
    render text: "Editing question: #{params[:id]}"
  end

  def new
    render text: "A new question" 
  end

  def destroy
    render text: "Question: #{params[:id]} has been successfully
deleted."
  end

end
```  
  
On the index.html.erb set some items to display each question,
including title, description, and created_at using Ruby's
[strftime](http://www.ruby-doc.org/core-2.1.1/Time.html#method-i-strftime)
method.  
```erb
# app/views/questions/index.html.erb
<h1>Listing All Questions</h1>

<% @questions.each do |question| %>
  
    <h2><%= question.title %></h2>
    <p><%= question.description %></p>
    <p>Created On: <%= question.created_at.strftime("%Y-%b-%d")
%></p>
    <hr>
    
<% end %>

```  
Let's create a page where we can fill in a question title and
description, and we can click a button to save it in the database. The
first step is inside the new method of our questions_controller.rb,
we will instantiate a question instance variable.  
```ruby
# app/controllers/questions_controller.rb  

# ...
def new
  @question = Question.new
end

# ...

```  
Now we need a view called 'new' to enter the information for our new
question.  
```erb
# app/views/questions/new.html.erb  
<h1>New Question</h1>

<% form_for @question do |f| %>

  <%= f.label :title %>
  <%= f.text_field :title %>
  
  <%= f.lable :description %>
  <%= f.text_area :description %>
  
  <%= f.submit %>
  
<% end %>

```  
Params is a hash of hashes, some of its keys have hashes inside,
auth.token, question {title: "...", description: "..."}. We can see
these parameters when we submit a new question.  
```bash
Started POST "/questions" for 127.0.0.1 at 2014-03-26 13:47:37 -0700
Processing by QuestionsController#create as HTML
  Parameters: {"utf8"=>"✓",
"authenticity_token"=>"w0WxTUZNQrbHnIHsuwfTYtJxKtYGzN3XlnOb88xc7qw=",
"question"=>{"title"=>"Here's a question",
"description"=>"kljsdlkajs ajsfd kljf;k djsaf"}, "commit"=>"Create
Question"}
```  
In your questions controller add a method create that will render text
showing the question title.    
```ruby
# app/controllers/questions_controller.rb  

# ...

def create
  render text: "Create..#{params[:question][:title]}"
end

# ...  
Now, to save this to the database, we will need to modify the
create method. We no longer have access to the instance variable from
the new request, so we need a new instance of question.  

```ruby
# app/controllers/questions_controller.rb  

# ...

def create
  @question = Question.new
  @question.title = params[:question][:title]
  @question.title = params[:question][:description]
  @question.save
  redirect_to questions_path
end

```  
Our logs have a lot of entries for accessing html/css files. We don't
really care about those, so to remove them, you can just add `gem
quiet_assets` to your Gemfile.  
  
Let's refactor that create method to be a little better.  
```ruby
# app/controllers/questions_controller.rb  

# ...

def create
  #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
  # now, in Rails 4, the default action is to prevent everything,
rather than allowing. 
  question_attributes = params.require(:question).permit([:title,
:description])
  @question = Question.new(question_attributes)
  
  if @question.save
    redirect_to questions_path, notice: "Your question was created
successfully."
  else
  flash.now[:error] = "PLease correct the form"
    render :new
  end
end

```  
In IRB, try saving an instance variable question without the
required params, then check the errors.  
```bash
q = Question.new
q.save
q.errors.any?
q.errors
q.errors.messages
```   
Let's add a way to display errors on our new question form:  
```erb
# app/views/questions/new.html.erb  
<% if @question.errors.any? %>

 <ul>
   <% @question.errors.full_messages.each do |message| %>
     <li><%= message %></li>
   <% end %>
  </ul>
<% end %>

<% form_for @question do |f| %>

  <%= f.label :title %>
  <%= f.text_field :title %>
  
  <%= f.lable :description %>
  <%= f.text_area :description %>
  
  <%= f.submit %>
  
<% end %>

```  
Set the flash notices to display through the application layout.  

```erb
#app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>AwesomeAnswers</title>
  <%= stylesheet_link_tag    "application", media: "all",
"data-turbolinks-track" => true %>
  <%= javascript_include_tag "application",
"data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>
  <div class="container">
    
    <nav class="nav-main">
      <%= link_to "About Us", about_us_path, class: "btn
btn-default nav-btn", id: "about" %>
      <%= link_to "FAQ", faq_path, class: "btn btn-default nav-btn" %>
      <%= link_to "Help", help_path, class: "btn btn-default nav-btn"
%>
      <%= link_to "New Question", new_question_path, class: "btn
btn-default nav-btn" %>
    </nav>
      
    <% if flash[:notice] || flash[:error] %>
      <h3><%= flash[:notice] || flash[:error] %></h3>
    <% end %>

    <%= yield %>
  
    
  
  </div>
</body>
</html>
```  
We can add private methods to our questions_controller.rb to clean this
up a little, and define the method for  questions_attributes
outisde the create method.  
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def create
    #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
    # now, in Rails 4, the default action is to prevent
everything, rather than allowing. 
    @question = Question.new(question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was
created successfully."
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end

  def show
  end

  def edit
    render text: "Editing question: #{params[:id]}"
  end

  def new
    @question = Question.new 
  end

  def destroy
    render text: "Question: #{params[:id]} has been successfully
deleted."
  end
  
  private
  
  def question_attributes
    question_attributes =
params.require(:question).permit([:title, :description])
  end
end
```
How do I add a link to my homepage in order to take me to a form where
I can create my new question?
  
```erb
# app/views/questions/index
 <h1>Listing All Questions</h1>
 
 <%= link_to "Create New Question", new_question_path %>
 
  <% @questions.each do |question| %>
 
  <h2><%= link_to question.title, question_path(question) %></h2>
 
  <p><%= question.description %></p>
 
  <p>Created On: <%= question.created_at.strftime("%Y-%b-%d") %></p>
 
  <hr>
 
 <% end %> 
```  
If I want to show the actual question, I should change my
questions controller. What should I do? And let's create a way to click
on a specific question, where I can view the details of that
question. And link back to the questions index page.  And even edit
or delete that question.  
```ruby
#app/controllers/questions_controller.rb

# ...

def show
  @question = Question.find(params[:id])
end

# ...
```

```erb
#app/views/questions/show.html.erb

<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<br>

<%= link_to "Edit", edit_question_path(@question) %>

<br>

<%= link_to "All Questions", questions_path %>

```  
Add a method in your questions_controller to edit.  
```ruby
# app/controllers/questions_controller.rb

#...

def edit
  @question = Question.find(params[:id])
end

#...


```
Edit Page  
```erb
# app/views/questions/edit.html/erb
<h1>Editing Question</h1>

<%= form_for @question do |f| %>
  
  <div class="form-field">
    <%= f.label :title, "TitLe" %>
    <%= f.text_field :title, class: "form-control" %>
  </div>

  <div class="form-field">
    <%= f.label :description %>
    <%= f.text_area :description, class: "form-control" %>
  </div>

  <%= f.submit %>

<% end %>
```  
Rather than repeat the same thing to instantiate a question in each
of your methods. It's a good idea to perform something called a
'before action' which will instantiate a question object for you.  

```ruby
class QuestionsController < ApplicationController
  before_action :find_question, 
                  only: [:show, :edit, :destroy, :update]

  def index
    @questions = Question.all
  end

  def create
    #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
    # now, in Rails 4, the default action is to prevent
everything, rather than allowing. 
    question_attributes =
params.require(:question).permit([:title, :description])
    @question = Question.new(question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was
created successfully."
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end
  
  def new
    @question = Question.new
  end

  def show
  end

  def edit
  end
  
  def update
  end

  def destroy
    render text: "Question: #{params[:id]} has been successfully
deleted."
  end
  
  private
  
  def find_question
    @question = Question.find(params[:id])
  end

end
```  
Also, rather than copy/pasting our form to mulitple pages, we can
create what's called a partial (note partial filenames begin with an
underscore "_").  
```erb
# app/views/questions/_form.html.erb
<%= form_for @question do |f| %>
  
  <div class="form-field">
    <%= f.label :title, "TitLe" %>
    <%= f.text_field :title, class: "form-control" %>
  </div>

  <div class="form-field">
    <%= f.label :description %>
    <%= f.text_area :description, class: "form-control" %>
  </div>

  <%= f.submit %>

<% end %>

```  
Then, we can call this form partial in a view file with 'render'  
```erb
# app/views/questions/new.html.erb

<h1>Create New Question</h1>

<%= render 'form' %>
```   
```erb
# app/views/questions/edit.html.erb

<h1>Edit Question</h1>

<%= render 'form' %>
```  
If you want to use a partial from another folder, you will need to use
the full path starting from views. For example,
views/questions/_form.html.erb.  
  
How can we get a different label on the button, based on wether the
question is in the database or not?   

`<%= f.submit (@question.persisted? ? "Update" : "Save"), class: "btn
btn-default" %>`  
  
To update a question in our databse through a form, we will create a
private method question_attributes  
```ruby
# app/controllers/questions_controller.rb

# ...
def update
  if @question.update_attributes(question_attributes)
    redirect_to @question, notice: "Question updated successfully"
  else
    flash.now[:error] = "Couldn't update!"
    render :edit
  end
end

private

def question_attributes
  params.require(:question).permit([:title, :description])
end

# ...
```  
Let's look now at the destroy action. What do I do to destroy a
record in the database?  
```ruby
# app/controllers/questions_controller.rb

#... 

def destroy
  if @question.destroy
    redirect_to questions_path, notice: "Question deleted
successfully."
  else
    redirect_to question_path, error: "We had trouble deleting."
  end
end
# ...  
```  
Then add a link to delete on the show page.  
```erb
# app/views/questions/show.html.erb
<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= link_to "Delete", @question, method: :delete, data: { confirm: "Are
you sure you want to delete this question?" } %>
<br>

<%= link_to "All Questions", questions_path %>


```  
## Adding Votes  
You can specify the field in the migration, like so: `rails g
migration add_vote_count_to_questions vote_count:integer`  
This creates the field for us in our migration file  
```ruby
# db/migrate/201403279827982374_add_vote_count_to_questions.rb
class AddVoteCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :vote_count, :integer
  end
end
```  
If you want to give it a default of 0, you can do so manually.  
```ruby
# db/migrate/201403279827982374_add_vote_count_to_questions.rb
class AddVoteCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :vote_count, :integer, default: 0
  end
end
```  
Run `rake db:migrate` Then add a vote up link to your show page  
```erb
#app/views/questions/show.html.erb

<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<br>
  <%= link_to "Vote Up", vote_up_question_path(@question) %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= button_to "Delete", @question, method: :delete, data: {
confirm: "Are you sure you want to delete this question?" },
class: "btn btn-default" %>
<br>

<%= link_to "All Questions", questions_path %>
```  

Add some methods in your questions controller to vote up and vote down  
```ruby
# app/controllers/questions_controller.rb

class QuestionsController < ApplicationController
  before_action :find_question, 
                  only: [:show, :edit, :destroy, :update,
:vote_up, :vote_down]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    #@question = Question.new(params[:question]) # We used to be able
to do this, but there were some security issues.
    # now, in Rails 4, the default action is to prevent
everything, rather than allowing. 
    question_attributes =
params.require(:question).permit([:title, :description])
    @question = Question.new(question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was
created successfully."
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update_attributes(question_attributes)
      redirect_to @question, notice: "Question updated successfully"
    else
      flash.now[:error] = "Couldn't update!"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: "Question deleted
successfully."
    else
      redirect_to question_path, error: "We had trouble deleting."
    end
  end
  
  def vote_up
    @question.increment!(:vote_count)
    session[:has_voted] = true
    redirect_to @question
  end
  
  def vote_down
  end
  
  def search
  end

  private

  def question_attributes
    params.require(:question).permit([:title, :description])
  end

  def find_question
    @question = Question.find(params[:id])
  end

end

```

Then inside the show, add a vote count  
```ruby
```  
In our routes.rb the default for vote up on our show path is get. We
could make it a button, or if we want to keep it a link, we could add
`method: :post`.  
```erb
# app/views/questions/show.html.erb
<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= @question.created_at.strftime("%Y-%b-%d") %>

<p>Vote Count: <%= @question.vote_count %>
<br>
  <% if session[:has_voted] %>
    You voted already!
    <% else %>
  <%= button_to "Vote Up", vote_up_question_path(@question) %>
  <% end %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= button_to "Delete", @question, method: :delete, data: {
confirm: "Are you sure you want to delete this question?" },
class: "btn btn-default" %>
<br>

<%= link_to "All Questions", questions_path %>
```  
## Adding Helper Methods  
We can use helper modules. When we use `rails generate
controller`, it automatically puts a helper for every controller in
the app/helpers directory.  
```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def formatted_date(date)
date.strftime("%Y-%dateB-%d")
end
end
```  
Then in the index view  
```erb
<h1>Listing All Questionsuestions</h1>

<%= link_to "Create a New Question", new_question_path %>

<% @questions.each do |question| %>

    <h2><%= link_to question.title, question_path(question) %></h2>
    <p><%= question.description %></p>
    <p><p>Created On: <%= formatted_date(@question.created_at) %></p>
    <hr>

<% end %>
```  
and in the show page
```erb
<h1><%= @question.title %></h1>
<p><%= @question.description %>
<p><%= formatted_date(@question.created_at) %>

<br>
<% if session[:sessionhas_voted] %>
  You voted already! 
  <% else %>
  <%= button_to "Votese Up", vote_up_question_path(@question) %>
    <% end %>

<br>
<%= link_to "Edit", edit_question_path(@question) %>

<%= button_to "Delete", @question, method: :delete, data: {
confirm: "Are you sure you want to delete this question?" },
class: "btn btn-default" %>
<br>

<%= link_to "All Questions", questions_path %>

```

### Available Callbacks  (ActiveRecord::Callbacks::CALLBACKS)
```bash
:after_initialize
:after_find
:after_touch
:before_validation
:after_validation
:before_save
:around_save
:after_save
:before_create
:around_create
:after_create
:before_update
:around_update
:after_update
:before_destroy
:around_destroy
:after_destroy
:after_commit
:after_rollback
```  
**Bonus**: Rather than setting the default values for vote_count to 0
in the migration file, we could add an `after_initialize` action to
the model.  

```ruby
# app/models/question.rb
#...

after_intitialize :set_defaults

private

def set_defaults
  self.vote_count ||= 0
end
```  
# Assets Pipeline in Rails  

  * app
    * assets
      * images
      * javascripts
      * stylesheets  
Rails uses a gem called
[sprockets](https://github.com/sstephenson/sprockets) to handle the
assets pipeline. This gives us some
[directives](https://github.com/sstephenson/sprockets#sprockets-directives)
available to require and access different files and folders within our
assets.  
  
***Sprockets Directives*** 
```bash
require
include
require_directory
The require Directive
require_tree
require_self
depend_on
The depend_on_asset
stub
```
  
application.css
```css
# app/assets/stylesheets/application.css
/*
 * This is a manifest file that'll be compiled into application.css,
   which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets,
   vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced
   here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll
   appear at the top of the
 * compiled file, but it's generally better to create a new file per
   style scope.
 *
 *= require_self
 *= require_tree .
 *= require_directory ./abc
 */
```  
## Layouts 
**nifty gem**:
[rails-layouts](http://railsapps.github.io/rails-default-application-layout.html)  
**note**: `%w` is shorthand for an array.  
```bash
my_array = %w(a b c d e)
# is equivalent to
my_array = ["a", "b", "c", "d", "e"]
```  
If you want different styles for different pages or namespaces on your
site, you can add layouts.  

Uncomment line 62 in your config.ru, and add a reference to external.css  
```ruby
# config.ru line 62
config.assets.precompile += %w( external.css )
```  
## Rake Tasks  
To see a list of tasks rake comes with try `bundle exec rake -T`. This
will give you something like this  
```bash
rake about                              # List versions of all Rails
frameworks and the environment
rake assets:clean[keep]                 # Remove old compiled assets
rake assets:clobber                     # Remove compiled assets
rake assets:environment                 # Load asset compile environment
rake assets:precompile                  # Compile all the assets named
in config.assets.precompile
rake cache_digests:dependencies         # Lookup first-level
dependencies for TEMPLATE (like messages/show or ...
rake cache_digests:nested_dependencies  # Lookup nested dependencies for
TEMPLATE (like messages/show or comme...
rake db:create                          # Create the database from
DATABASE_URL or config/database.yml for the...
rake db:drop                            # Drops the database using
DATABASE_URL or the current Rails.env (use ...
rake db:fixtures:load                   # Load fixtures into the current
environment's database
rake db:migrate                         # Migrate the database (options:
VERSION=x, VERBOSE=false, SCOPE=blog)
rake db:migrate:status                  # Display status of migrations
rake db:rollback                        # Rolls the schema back to the
previous version (specify steps w/ STEP=n)
rake db:schema:cache:clear              # Clear a db/schema_cache.dump
file
rake db:schema:cache:dump               # Create a db/schema_cache.dump
file
rake db:schema:dump                     # Create a db/schema.rb file
that can be portably used against any DB ...
rake db:schema:load                     # Load a schema.rb file into the
database
rake db:seed                            # Load the seed data from
db/seeds.rb
rake db:setup                           # Create the database, load the
schema, and initialize with the seed d...
rake db:structure:dump                  # Dump the database structure to
db/structure.sql
rake db:version                         # Retrieves the current schema
version number
rake doc:app                            # Generate docs for the app --
also available doc:rails, doc:guides (o...
rake log:clear                          # Truncates all *.log files in
log/ to zero bytes (specify which logs ...
rake middleware                         # Prints out your Rack
middleware stack
rake notes                              # Enumerate all annotations (use
notes:optimize, :fixme, :todo for focus)
rake notes:custom                       # Enumerate a custom annotation,
specify with ANNOTATION=CUSTOM
rake rails:template                     # Applies the template supplied
by LOCATION=(/path/to/template) or URL
rake rails:update                       # Update configs and some other
initially generated files (or use just...
rake routes                             # Print out all defined routes
in match order, with names
rake secret                             # Generate a cryptographically
secure secret key (this is typically us...
rake stats                              # Report code statistics (KLOCs,
etc) from the application
rake test                               # Runs test:units,
test:functionals, test:integration together
rake test:all                           # Run tests quickly by merging
all types and not resetting db
rake test:all:db                        # Run tests quickly, but also
reset db
rake test:recent                        # Run tests for
{:recent=>["test:deprecated", "test:prepare"]} / Depre...
rake test:uncommitted                   # Run tests for
{:uncommitted=>["test:deprecated", "test:prepare"]} / ...
rake time:zones:all                     # Displays all time zones, also
available: time:zones:us, time:zones:l...
rake tmp:clear                          # Clear session, cache, and
socket files from tmp/ (narrow w/ tmp:sess...
rake tmp:create                         # Creates tmp directories for
sessions, cache, sockets, and pids
```  
If you want to precompile your assets to see what they look like, you
can run  
```bash
bundle exec rake assets:precompile RAILS_ENV=production
```  
***Note***: You may need to add a production database to your
database.yml. In this case, we're using our test database for production
locally.    
```yml
development:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_development
  pool: 5
  username: [my-user-name]
  password:

test:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_test
  pool: 5
  username: [my-user-name]
  password:

production:
  adapter: postgresql
  encoding: unicode
  database: awesome_answers_test
  pool: 5
  username: [my-user-name]
  password:

```
```bash
bundle exec rake assets:precompile
```
This will give you an assets directory in your public folder.  

To add an image, simply add one to your images directory in the assets
path, then you can access it with image_tag    
```
# app/views/question/index.html.erb
<h1>Welcome to our Site</h1>

<%= image_tag "drewbro.jpg" %>
```  
## Add Bootstrap to your App  
In your Gemfile add the bootstrap gem  
```ruby
# Gemfile

source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'pg'
gem 'thin'
gem 'bootstrap-sass', '~> 3.1.1.0'


gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :development do
  gem 'hirb'
  gem 'interactive_editor'
  gem 'awesome_print'
  gem 'quiet_assets'
end

group :doc do
  gem 'sdoc', require: false
end
```  
Then run `bundle install` in the terminal.  
  
in app/assets/stylesheets add a file like
`bootstrap_and_css_overrides.css.scss`
```css
# app/assets/stylesheets/bootstrap_and_css_overrides.css.scss
@import 'bootstrap';
```  

## Deploy to Heroku  
Because we're deploying to heroku, if you have done a `rake
assets:precompile`, you should delete your assets directory in the
public folder.  
```ruby
git init
git add .
git commit -m "Initial commit"
git log

heroku create
git remote -v
git push heroku master

heroku run rake db:migrate

heroku open
```
# HAML  
Hey HAML, why you so nice?  
  
Link: [HTML2HAML](http://html2haml.heroku.com/) |
[Styleguide](https://github.com/dbooom/styleguide/blob/master/_styleguide.haml)
| [HAML
Cheetsheet](http://www.cheatography.com/specialbrand/cheat-sheets/haml/)       

HTML  
```html
<!DOCTYPE html>

<html>

  <head>

    <meta charset="utf-8">

    <title>My Super Awesome Page</title>
  
    <meta keywords="">

    <meta discription="">

    <link rel="stylesheet" href="assets/stylesheets/styles.css">

    <script src="assets/javascripts/myscripts.jss"></script>

  </head>
  <body>

  <h1>This is cool</h1>

  <p>This paragraph is actually about everything that isn't. That's
right! It's about nothing :)</p>

  </body>

</html>
```  
Haml  
```haml
!!!
%html
  %head
    %meta{charset: "utf-8"}/
    %title My Super Awesome Page
    %meta{keywords: ""}/
    %meta{discription: ""}/
    %link{href: "assets/stylesheets/styles.css", rel: "stylesheet"}/
    %script{src: "assets/javascripts/myscripts.jss"}
  %body
    %h1 This is cool
    %p This paragraph is actually about everything that isn't. That's
right! It's about nothing :)
```  
# Add Answers to Awesome Answers  
[Vestal Version](https://github.com/laserlemon/vestal_versions) |  
  
```bash
rails generate model answer body:text question:references
```  
**note**: If you are adding a reference to an existing project, you can
make a migration like  
```bash
rails g migration add_project_references_to_tasks project:references
```
  
This gives the migration file  
```ruby
class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, index: true

      t.timestamps
    end
  end
end
```  
Run `bundle exec rake db:migrate` and open up the model: question.rb,
where we will add `has_many`, and make it `dependent: :destroy` if you
want the answers to be deleted if the question is.      
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  #validates_presence_of :title
  validates :title, presence: {message: "must be there"}  , uniqueness:
true

  validates_presence_of :description, message: "must be present"

  # after_intitialize :set_defaults

  # a default scope will be used for al queries
  default_scope {order("title ASC")}

  # "->" is shorthand for lambda
  # to pass in a variable, use "->(x)"
  # scope :recent_tn, lambda { order("created_at DESC").limit(10) }

  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }

  # this can be shorted by writing a scope
  def self.recent_ten
    order("created_at DESC").limit(10)
  end

  def self.recent(x)
    order("created_at DESC").limit(x)
  end

  before_save :capitalize_title             # call the before_save
action :capitalize_title

  private

  def capitalize_title                 # create a method to capitalize
the title before saving
    self.title.capitalize!
  end



end
```  
In the answer model, because we used `question:references` when we
generated the model, we have `belongs_to`  
```ruby
class Answers < ActiveRecord::Base
  belongs_to :question
end
```  

In Rails Console, get a question instantiated, and give it an answer.  
```ruby
question = Question.last
answer1 = Answer.new(body: "This is my answer!")

question.answers << answer1
  
# We can chain other scopes with the association.  
question.answers.where(body: "something")
```  
*Generate a controller*  
```
rails generate controller answers
```  
Add routes for answers  
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do

  resources :questions, only: [:new, :index, :create, :show, :edit,
:destroy] do
    resources :answers
    member do
      post :vote_up
      post :vote_down
    end
    post :search, on: :collection
  end

end
```  
Check your [routes](localhost:3000/rails/info/routes).  
  
Add a form for answers on your questions show view  
```haml
    %h2 Add an Answer
    = form_for @answer, url: question_answers_path(@question)
      do |f|
      = f.text_area :body
      %br
      = f.submit "Submit an answer", class: "btn btn-primary"
```  
  
instantiate a new answer in the questions controller show method
```ruby
app/controllers/questions_controller.rb

  # ...
  def show
    @answer = Answer.new
  end
  # ...
```  
Give your answers controller a create method  
```ruby
class AnswersController < ApplicationController

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answer.new(answer_attributes)
    if @answer.save
    redirect_to @question, noticee: "Answer created successfully."
    else
      render "/questions/show"
    end
  end


  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

end
```  
Add validation to the answer model  
```ruby
class Answer < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :body
end
```  
And add a way to display any errors on the questions show page  
```haml
%h1= @question.title
%p
  = @question.description
  %p
    = formatted_date(@question.created_at)
    = succeed "Vote" do
      %br/
    Count: #{@question.vote_count}
    %br/
    - if session[:has_voted]
      You voted already!
    - else
      = button_to "Vote Up", vote_up_question_path(@question)
    %br/
    = link_to "Edit", edit_question_path(@question)
    = button_to "Delete", @question, method: :delete, data: { confirm:
"Are you sure you want to delete this question?" }, class: "btn
btn-default"
    %br/
    = link_to "All Questions", questions_path

    %h2 Add an Answer
    - if @answer.errors.any?
      %ul
        - @answer.errors.full_messages.each do |message|
          %li= message

    = form_for @answer, url: question_answers_path(@question) do |f|
      = f.text_area :body
      %br
      = f.submit "Submit an answer", class: "btn btn-primary"
```  
Modify the show view to display the answers.  
```haml

    = form_for @answer, url: question_answers_path(@question) do |f|
      = f.text_area :body
      %br
      = f.submit "Submit an answer", class: "btn btn-primary"

    %hr
    -@question.answers.each do |answer|
      .well
        %p= answer.body
        %p Created on #{formatted_date(answer.created_at)}
```

To display the answers ordered by creation just make a scope in the
answer model  
```ruby
class Answer < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :body

  scope :ordered_by_creation, -> { order("created_at DESC")}
end
```  
Then in the questions controller, instantiate a answers variable to pass
to the show view that calls the scope `ordered_by_creation`  
```ruby
  def show
    @answer = Answer.new
    @answers = @qustion.answers.ordered_by_creation
  end
```
# Rails: One to Many  

*note*: Add [form
validation](http://getbootstrap.com/css/#forms-control-validation) with
bootstrap classes.  


```ruby
# config/routes.rb
# Nesting three levels deep is bad
resources :projects do
  resources :discussions do
    resources :comments
  end
end

# This will give cleaner routs
resources :projects do
  resources :discussions
end

resources :discussions do
  resources :comments
end

```  
  
```ruby
resources :answers, only: [] do
  resources :comments
end

resources :questions do
  resources :answers
  member do
    post :vote_up
    post :vote_down
  end
  post :search, on: :collection
end
```  
  
If you want localhost:3000/asjfadsjfa to link to questions index, you
could  
```ruby
get "/asjfadsjfa" => "questions#index" #

```  
  
## Add delete button for every answer  
 
Our routes show the question asnwer path as
`/questions/:question_id/answers/:id(.:format)`. So, we can pass in the
@question and @answer variables using the `question_answers_path` helper
method.  
```haml
/app/views/show.html.haml
# ...
    %hr
    -@question.answers.each do |answer|
      .well
        .row
          .col-sm-8.col-md-8.col-xs-8
            %p= answer.body
            %p Created on #{formatted_date(answer.created_at)}
          .col-sm-8.col-md-8.col-xs-8
            .pull-right= button_to "Delete",
question_answers_path(@question, @answer), method: :delete, class: "btn
btn-danger", data: {confirm: "Are you sure you want to delete the
answer?"}
```  
Add a method to delete in the answers controller  
```ruby
# answers_controller.rb
class AnswersController < ApplicationController
  before_action :find_question

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.new(answer_attributes)
    if @answer.save
      redirect_to @question, notice: "Answer created successfully."
    else
      render "/questions/show"
    end
  end

  def destroy
    @answer = @questions.answers.find(params[:id])
    if @answer.destroy
      redirect_to @question, notice: "Answer deleted"
    else
      redirect_to @question, error: "We had trouble deleting the answer"
    end
  end

  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

  def find_question
    @question = Question.find params[:question_id]
  end
end
```  

We can use the well that displays our answers as a partial. To do so,
simply copy it out of our questions/show page, and create a file under
answers that begins with an underscore.
```haml
# views/answers/_answer.html.haml
.well
  .row
    .col-sm-8.col-md-8.col-xs-8
      %p= answer.body
      %p Created on #{formatted_date(answer.created_at)}
    .col-sm-4.col-md-4.col-xs-4
      .pull-right= button_to "Delete", question_answer_path(@question,
@answer), method: :delete, class: "btn btn-danger", data: {confirm: "Are
you sure you want to delete the answer?"}
```  
Then reference that partial in the questions page.  
```haml
/ views/questions/show.html.haml

  %hr
  -@question.answers.each do |answer|
  = render "/answers/answer", answer: answer
```  
Rails has a shortcut for this, provided all the variables and files are
following the same naming scheme, as we have in our case.  
```haml
%hr
= render @answers
```   

We can change the AnswersController to inherit from the
QuestionsController so then answers have access to the methods available
to question.  
```ruby
class AnswersController < QuestionsController
  before_action :find_question

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.new(answer_attributes)
    if @answer.save
    redirect_torect_to @question, notice: "Answer created successfully."
    else
      render "/questions/show"
    end
  end

  def destroy
    @answer = @questions.answers.find(params[:id])
    if @answer.destroy
      redirect_to @question, notice: "Answer deleted"
    else
      redirect_to @question, error: "We had trouble deleting the answer"
    end
  end


  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

end
```  
We no longer need a private method to find a question in the
AnswersController, and can instead add an or by id to the find question
method in the QuestionsController.  
```ruby
# app/controllers/questions_controller.rb
#...

  def find_question
    @question = Question.find(params[:question_id] || params[:id])
  end
```
## Comments  
Add a comment model `rails generate resource comment body:text
answer:references`   
Add a has many to the answer model and make it `dependent: :destroy` so
we don't have any orphaned information left in the database.    
```ruby
# app/models/answer.rb
class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :comments, dependent: :destroy

  validates_presence_of :body

  scope :ordered_by_creation, -> { order("created_at DESC")}
end
```  
Test it out in rails c  
```ruby
a = Answer.find 11
a.comments.create(body: "asdfasdf")
```  
Let's add `better_errors` and `binding_of_caller` gems to your
development group:   
```
# Gemfile

# ...

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'interactive_editor'
  gem 'awesome_print'
  gem 'quiet_assets'
end

#...
```  
## Rails: Has One  
   
We'll use a seperate model to keep things clean.  
```bash
rails generate model question_detail notes:text question:references
```  

Now if we go to QuestionDetail.rb, we see it belongs to question  
```ruby
class QuestionDetail < ActiveRecord::Base
  belongs_to :question
end
```  
add `has_one :question_detail` to the question model.  
  
Now, if we go to `rails console` we can do some stuff that we can only
do with a `has_one`    
```ruby
  # has_one
  question.build_question_detail(notes: "asdjklasj")
  question.create_question_detail(notes: "klajsdlks")
  
  # has_many
  question.answers.build(notes: "Hey")
  question.answers.create(notes: "Hey")

```  
Some rails c stuff
```
q = Question.first
qd = q.build_question_detail
qd.notes = "kajsdkjasdkjhsa"
qd
qd.save
```
# User Authentication with Devise  
[Devise](https://github.com/plataformatec/devise) | [Devise w/
OAUTH](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)
|  
  
Add `gem 'devise'` to your gemfile  
```ruby
# Gemfile
source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'pg'
gem 'thin'
gem 'bootstrap-sass', '~> 3.1.1.0'
gem 'haml-rails'
gem 'devise'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :development do
  gem 'hirb'
  gem 'interactive_editor'
  gem 'awesome_print'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :doc do
  gem 'sdoc', require: false
end
```  
Then run (in terminal):  
```bash
bundle install
rails generate devise:install
```  
Then, follow the instructions (we can skip step 4, since we're using
Rails 4.1):  
```bash
Some setup you must do manually if you haven\'t yet:

  1. Ensure you have defined default url options in your environments
     files. Here
     is an example of default_url_options appropriate for a development
environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { :host =>
'localhost:3000' }

     In production, :host should be set to the actual host of your
application.

  2. Ensure you have defined root_url to *something* in your
     config/routes.rb.
     For example:

       root :to => "home#index"

  3. Ensure you have flash messages in
     app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to
     set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the
DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by
     running:

       rails g devise:views
```  
If you want a model to be linked with devise, use `rails generate devise
[model-name]` so in this case, we'll try:  
`rails generate devise user first_name:string last_name:string`  
Then we can run `rake db:migrate` or `bundle exec rake db:migrate`.  
  
Open up the User model  
```ruby
# app/models/user.rb  
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```  
You can now check our [routes](http://localhost:3000/rails/info/routes)
and see all the new paths for users.  
  
Let's set up some authentications in the questions controller  
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
# more code...
```  
You can alter the form to look differently, if you'd like under new
sessions  
```erb
# app/views/devise/sessions/new.html.erb 
<h2>Sign in</h2>

<%= form_for(resource, :as => resource_name, :url =>
session_path(resource_name)) do |f| %>
  <div><%= f.label :email %><br />
  <%= f.email_field :email, :autofocus => true, class: "form-control"
%></div>

  <div><%= f.label :password %><br />
  <%= f.password_field :password, class: "form-control" %></div>

  <% if devise_mapping.rememberable? -%>
    <div><%= f.check_box :remember_me, class: "form-control" %> <%=
f.label :remember_me %></div>
  <% end -%>

  <div><%= f.submit "Sign in", class: "btn btn-default" %></div>
<% end %>

<%= render "devise/shared/links" %>
```  
When we hit 'sign up' notice the default fields for Devise are to use
use email, password, and password confirmation.  
  
Add a sign out button to the application layout if user is signed in,
and sign in if not signed in.    
```haml
/ app/views/application/application.layout.haml
!!!
%html
  %head
    %title AwesomeAnswers
    = stylesheet_link_tag    "application", media: "all",
"data-turbolinks-track" => true
    = javascript_include_tag "application", "data-turbolinks-track" =>
true
    = csrf_meta_tags
  %body
    .container
      %nav.nav-main
        - # link_to "About Us", about_us_path, class: "btn btn-default
          nav-btn", id: "about"
        - # link_to "FAQ", faq_path, class: "btn btn-default nav-btn"
        - # link_to "Help", help_path, class: "btn btn-default nav-btn"
        = link_to "home", questions_path, class: "btn btn-default"
        = link_to "New Question", new_question_path, class: "btn
btn-default nav-btn"
        .pull-right
          - if user_signed_in?
            Hello
            = current_user.full_name
            = link_to "sign out", destroy_user_session_path, method:
:delete, class: "btn btn-default"
          - else
            = link_to "sign in", new_user_session_path, class: "btn
btn-default"
      - if flash[:notice] || flash[:error]
        %h3= flash[:notice] || flash[:error]

      =yield
```  
Add first and last name fields to devise new user registration form  
```erb
<h2>Sign up</h2>

<%= form_for(resource, :as => resource_name, :url =>
registration_path(resource_name)) do |f| %>
  <%= devise_error_messages! %>
  
  <div><%= f.label :first_name %><br />
  <%= f.text_field :first_name, class: "form-control" %></div>

  <div><%= f.label :last_name %><br />
  <%= f.text_field :last_name, class: "form-control" %></div>

  <div><%= f.label :email %><br />
  <%= f.email_field :email, :autofocus => true, class: "form-control"
%></div>

  <div><%= f.label :password %><br />
  <%= f.password_field :password, class: "form-control" %></div>

  <div><%= f.label :password_confirmation %><br />
  <%= f.password_field :password_confirmation, class: "form-control"
%></div>

  <div><%= f.submit "Sign up", class: "btn btn-default" %></div>
<% end %>

<%= render "devise/shared/links" %>
```  
To allow these fields to the strong parameters, the problem is we don't
have access to the devise controller, because it's embeded in the gem.
The cool thing is we can do this in the application controller.  
```ruby  
# app/controllers/applications_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_params, if: :devise_controller?

  private
  
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << 
                                    [:first_name, :last_name]
    devise_parameter_sanitizer.for(:account_update) << 
                                    [:first_name, :last_name]
  end

end
```  
add a full name method to the User model
```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".squeeze.strip
    else
      email
    end
  end
  
end
```  
How do we made a 'user has many questions' or 'user has many answers'
relationship?  
```bash
rails generate migration add_user_references
```
Then open up the migration file and add user references to questions and
answers    
```ruby
#migration/asdkjaslkdj/add_user_references.rb
class AddUserReferences < ActiveRecord::Migration
  def change
    add_reference :questions, :user, index: true
    add_reference :answers, :user, index: true
  end
end
```  
Add 'has many' relation to the user model  
```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers


  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".squeeze.strip
    else
      email
    end
  end
  
end
```  
Add belongs to user to the question model  
```ruby
# app/models/user.rb
# ...
belongs_to :user
#...
```  
Add a current user to the create action in the questions controller
```ruby
# app/controllers/questions_controller.rb
# this:
# @question.user = current_user
# or:
@question = current_user.questions.new(question_attributes)
```  
We can change the private method find_questions in the questions
controller to find based on the current user, or redirect back to the
root path with an alert.    
```ruby
  def find_question
    #@question = Question.find(params[:question_id] || params[:id])
    # @question = current_user.questions.find(params[:question_id] ||
params[:id])
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_path, alert: "Access Denied" unless @question
  end
```  
***note***: We can remove show from the before action to find question,
and modify the show method to find its own question, if we wish for
unregistered (or non signed in) users to be able to view questions.  
```ruby
# app/controllers/questions_controller.rb
#...
before_action :find_question, 
                  only: [:edit, :destroy, :update, :vote_up, :vote_down]

#...
def show
  @question = Question.find(params[:question_id] || params[:id])
  @answer = Answer.new
  @answers = @question.answers.ordered_by_creation
end
# ...
```  
If you have old questions without user ids, you can add them like by
running this in your rails console  
```bash
Question.update_all(user_id: 1)
```  
Inside the answer's controller, I can do the same thing in the create
method. And modify the destroy method to make sure the user is the
current user.  
```ruby
# app/controllers/answers_controller.rb
#...

  def create
    #@question = Question.find params[:question_id]
    @answer = @question.answers.new(answer_attributes)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: "Answer created successfully."
    else
      render "/questions/show"
    end
  end
#...

  def destroy
    @answer = @question.answers.find(params[:id])
    if @answer.user = current_user && @answer.destroy
      redirect_to @question, notice: "Answer deleted"
    else
      redirect_to @question, error: "We had trouble deleting the answer"
    end
  end

#...

```
# Many to Many Relations  
Start by creating category and categorization models.  
```bash
rails generate model category title:string
rails generate model categorization category:references
question:references
bundle exec rake db:migrate
```  
Open up the rails console, and let's come up with an array of categories
then create them.  
```bash
# Add the categories
["Art", "Science", "Technology", "Sports", "Travel", "Humor"].each {|x|
Category.create(title: x)}
# or
%w(Art Science Technology Sports Travel Humor).each {|x|
Category.create(title: x)}

# View the categories
Category.all

# Somecool shorthand with Ampersand and map
Category.all.map(&:title)
```  

Open up Category and add has many associations
```ruby
# app/models/category.rb
class Category < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :questions, through: :categorizations
end
```  
Add associations to the answer model
```ruby
# app/models/question.rb
class Question < ActiveRecord::Base
#...
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :catorizations
#...
end

```  
More rails console stuff  
```bash
q = Question.first
c1 = Category.first
c1 = Category.find 2
q.categories << c1
q.categories << c2
q.categories
Categorization.all
```  
Add display of errors to questions form
```haml
- if @question.errors.any?
  %ul
    - @question.errors.full_messages.each do |message|
      %li message

= form_for @question do |f|
  .form-field
    = f.label :title, "Title"
    = f.text_field :title, class: "form-control"
  .form-field
    = f.label :description
    = f.text_area :description, class: "form-control"
  .form-field
    = check_box_tag(:pet_dog)
    = label_tag(:pet_dog, "I own a dog")
    = check_box_tag(:pet_cat)
    = label_tag(:pet_cat, "I own a cat")
  = f.submit class: "btn btn-default"
```
  
Then in the questions controller, add category ids to the permited
params in the private question attributes method.  
```ruby
#...
  def question_attributes
    params.require(:question).permit([:title, :description,
{category_ids: []}])
  end
#...
```  
Add some checkboxes for your question form  
```haml
/ app/views/questions/_form.html.haml
- if @question.errors.any?
  %ul
    - @question.errors.full_messages.each do |message|
      %li message

= form_for @question do |f|
  .form-field
    = f.label :title, "Title"
    = f.text_field :title, class: "form-control"
  .form-field
    = f.label :description
    = f.text_area :description, class: "form-control"
  
  = f.collection_check_boxes :category_ids, Category.order("title"),
:id, :title
  %br
  = f.submit class: "btn btn-default"
```
Add the categories to the question show page  
```haml
%h1= @question.title
%p
  = @question.description
  %p
    = formatted_date(@question.created_at)
    = succeed "Vote" do
      %br
    Count: #{@question.vote_count}
    %br
    - if @question.categories.present?
      Categories (#{@question.categories.count}):
      = @question.categories.map(&:title).join(", ")
    %br
    - if session[:has_voted]
      You voted already!
    - else
      = button_to "Vote Up", vote_up_question_path(@question)
    %br/
    = button_to "Delete", @question, method: :delete, data: { confirm:
"Are you sure you want to delete this question?" }, class: "btn
btn-default"
    %br/
    = link_to "All Questions", questions_path

    %h2 Add an Answer
    - if @answer.errors.any?
      %ul
        - @answer.errors.full_messages.each do |message|
          %li= message

    = form_for @answer, url: question_answers_path(@question) do |f|
      = f.text_area :body, class: "form-control"
      %br
      = f.submit "Submit an answer", class: "btn btn-primary"

    %hr
    -@question.answers.each do |answer|
      = render "/answers/answer", answer: answer
```
# Vote Up and Down
  
Let's create both a model and controller with one command

```bash
rails g resource vote is_up:boolean question:references user:references
```  
Open the vote model and add validation for uniqueness based on user id  
```ruby
# app/models/vote.rb
class Vote < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :question_id, uniqueness: {scope: :user_id}
end
```  
Add some route logic, and we can now remove the vote up and vote down
methods from the questions controller    
```ruby
# config/routes.rb
AwesomeAnswers::Application.routes.draw do
 
  devise_for :users
  root "questions#index"
  get "/test" => "questions#test"
  resources :answers, only: [] do
    resources :comments
  end
  
  resources :questions do
    resources :votes, only: [:create, :update, :destroy]
    resources :answers
    post :search, on: :collection
  end
end
```
Add has many to the user model  
```ruby
class User < ActiveRecord::Base

#...

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question 

#...
  
end
```  
Add to has many relations to the user model for votes  
```ruby
# app/models/user.rb
class Question < ActiveRecord::Base

  #...
  
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user

  #...

end
```  
Instantiate a new vote in the questions controller and create a form for
voting  
```ruby
# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController

  #...
  
  def show
    @question = Question.find(params[:question_id] || params[:id])
    @answer = Answer.new
    @vote = Vote.new
    @answers = @question.answers.ordered_by_creation
  end
  
  #...
  
end
```
```haml
/ app/views/questions/show.html.haml

#...

    = form_for [@question, @vote] do |f|
      = f.hidden_field :is_up, vlaue: true
      = f.submit "Vote Up", class: "btn btn-default"
    %br
    = form_for [@question, @vote] do |f|
      = f.hidden_field :is_up, vlaue: false
      = f.submit "Vote down", class: "btn btn-default"
    %br

#...

```  
Your show page should now look like this  
```haml
= link_to "Edit", edit_question_path(@question), class: "btn
btn-default"
%h1= @question.title
%p
  = @question.description
  %p
    = formatted_date(@question.created_at)
    = succeed "Vote" do
      %br
    Count: #{@question.vote_count}
    %br
    - if @question.categories.present?
      Categories (#{@question.categories.count}):
      = @question.categories.map(&:title).join(", ")
    %br
    
    = form_for [@question, @vote] do |f|
      = f.hidden_field :is_up, value: true
      = f.submit "Vote Up", class: "btn btn-default"
    %br
    = form_for [@question, @vote] do |f|
      = f.hidden_field :is_up, value: false
      = f.submit "Vote down", class: "btn btn-default"
    %br

    = button_to "Delete", @question, method: :delete, data: { confirm:
"Are you sure you want to delete this question?" }, class: "btn
btn-default"
    %br/
    = link_to "All Questions", questions_path

    %h2 Add an Answer
    - if @answer.errors.any?
      %ul
        - @answer.errors.full_messages.each do |message|
          %li= message

    = form_for @answer, url: question_answers_path(@question) do |f|
      = f.text_area :body, class: "form-control"
      %br
      = f.submit "Submit an answer", class: "btn btn-primary"

    %hr
    -@question.answers.each do |answer|
      = render "/answers/answer", answer: answer
```  
Add a create method to the votes controller with a before action, and
vote params.    
```ruby
class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question   = Question.find.params(:question_id)
    @vote       = @question.votes.new(vote_params)
    @vote.user  = current_user
    if @vote.save
      redirect_to @question, notice: "Thanks for voting"
    else
      redirect_to @question, alert: "Your vote wasn't recorded!"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end
end
```  
***note***: Change 'error' to 'alert' on your application layout and
questions controller.  

Change the questions controller show method to find the current user, or
instantiate a new vote    
```ruby  
class QuestionsController < ApplicationController
  #...
  
  def show
    @question = Question.find(params[:question_id] || params[:id])
    @answer   = Answer.new
    @vote     = current_user.vote_for(@question) || Vote.new
    @answers  = @question.answers.ordered_by_creation
  end
  
  #...

end
```  
Define a vote_for method in the user model  
```ruby
class User < ActiveRecord::Base

  #...
  
  def vote_for(question)
    Vote.where(question: question, user: self).first
  end
  
  #...
  
end

```  
Rails c fun  
```bash
current_user = User.find 1
@question = current_user.questions[0]
@vote = current_user.vote_for(@question) || Vote.new
@vote.persisted?
Vote.new.persisted?
Vote.first.persisted?
```  
Add an if else statement to the questions show page to show the option
to 'undo' if voted, or to 'vote up' if not.   
```haml
    - if @vote.persisted? && @vote.is_up?
      = button_to "Undo", [@question, @vote], method: :delete, class:
"btn btn-default"
    - else
      = form_for [@question, @vote] do |f|
        = f.hidden_field :is_up, value: true
        = f.submit "Vote Up", class: "btn btn-default"
```  
Add an update and destroy action to the votes controller, and a before
action to find the question  
```ruby
class VotesController < ApplicationController
  before_action :find_question

  #...

  def destroy
    @vote = current_user.votes.find(params[:id])
    if @vote.destroy
      redirect_to @question, notice: "Vote removed"
    else
      redirect_to @question, alert: "Vote couldn't be removed"
    end
  end

  def update
    @vote = current_user.votes.find(params[:id])
    if @vote.update_attributes(vote_params)
      redirect_to @question, notice: "Vote updated."
    else
      redirect_to @question, alert: "Vote not updated"
    end
  end

  #...

  def find_question
    @question = Question.find(params[:question_id])
  end

end

```
#Many to Many: Favorite an Answer  
  
Generate a favorite model that has question and user references
```bash
rails g resource favorite question:references user:references
```  
Resources
```ruby
# config/routes.rb
resources :questions do
  resources :favorites, only: [:create, :destroy]
  resources :votes, only: [:create, :update, :destroy]
  resources :answers
  post :search, on: :collection
end
```  
Add create and destroy methods to the favorites controller with a before
action that authenticates the user.  
```ruby
# app/controllers/favorites_controller.rb

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find params[:question_id]
    @favorite = @question.favorites.new
    @favorite.user = current_user

    if @favorite.save
      redirect_to @question, notice: "Thank you for favoriting"
    else
      redirect_to @question, alert: "You question could not be saved"
    end
  end

  def destroy
  end
end
```  
How can we do the favorite on the show page? We can get rid of the vote
count.    
```haml
/ app/views/questions/show.html.haml

 = button_to "Favorite", question_favorites_path(@question), method:
:post
 
```  
Add has many relations to the question model
```ruby

#...

# app/models/question.rb
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
#...

```
And the user model
```ruby
# app/models/user.rb

#...

has_many :favorites, dependent: :destroy
has_many :favorited_questions, through: :favorites, source: :question

#...
```  
How do we enforce at the model level that the user doesn't vote twice?  
```ruby
# app/models/favorite.rb

#...

validates :user_id, uniqueness: {scope: :question_id}

#...
```  
## Add an 'unfavorite' button
```haml
/ app/questions/views/show.html.haml

/...
%p= button_to "Unfavorite", question_favorites_path(@question,
@favorite), method: :delete, class: "btn btn-default"
/...
```  
In the questions controller, add an instance variable for @favorite in
the show method.  
```ruby

#...
# app/controllers/questions_controller.rb

  def show
    @question = Question.find(params[:question_id] || params[:id])
    @answer   = Answer.new
    @favorite = current_user.favorite_for(@question)
    @vote     = current_user.vote_for(@question) || Vote.new
    @answers  = @question.answers.ordered_by_creation
  end

#...
```  
Add a `favorite_for` method in the User model.  
```ruby
# app/models/user.rb

#...
  def favorite_for(question)
    favorites.where(question: question).first
  end
  
#...
```  
Add to the destroy method in the favorites controller, and add a before
action to find a question.  
```ruby
# app/controllers/favorites_controller.rb

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @question = Question.find params[:question_id]
    @favorite = @question.favorites.new
    @favorite.user = current_user

    if @favorite.save
      redirect_to @question, notice: "Thank you for favoriting"
    else
      redirect_to @question, alert: "Your question could not be saved"
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    if @favorite.destroy
      redirect_to @question, "You have unfavorited"
    else
      redirect_to @question, alert: "Couldn't unfavorite"
    end
  end

  private

  def find_question
    @question = Question.find params[:question_id]
  end

end


```  
Change the questions show view to display 
```haml
/ app/views/questions/show.html.haml


/...

- if @favorite
  %p= button_to "Unfavorite", question_favorites_path(@question,
@favorite), method: :delete, class: "btn btn-default"
- else
  %p= button_to "Favorite", question_favorites_path(@question), method:
:post, class: "btn btn-default"

/...

```
Add a list of favorited users to the show page.
```haml
/ app/views/quetions/show.html.haml

# ...

- if @question.favorited_users.present?
  Favoritd Users:
  = @question.favorited_users.map(&:full_name).join(", ")

# ...
```
# jQuery & CoffeeScript  
Open awesome answers... and use the js console in your browser
```javascript
$('img').animate({width: "50"});
$('img').animate({width: "100", height: "200"});
$('img').animate({width: "+=100"});
$('img').animate({width: "50%"});
$('img').animate({width: "-=10", height: "-=10"});
```  
Another thing we can check with animate, is how long it is animating
for.  
```javascript
$('img').animate({width: "100", height: "200"}, 5000);
```  
And the last thing we can do is pass in a function to execute after the
animation has happened.  
```javascript
$('img').animate({width: "100", height: "200"}, 5000,
function(){alert("animation complete")});
$('img').animate({width: "100", height: "200"}, 5000,
function(){alert("animation complete")});

// We can select by element, class, id
$('.btn').fadeOut(5000, function(){console.log("finished")});
$('.btn').slideUp();
$('.btn').slideDown();
$('.btn').slideDown(5000, function(){console.log("finished");});
```  
1.) Create a function that scales a picture up, then fades it out.  
```javascript
var bigFade = function() {
  $('img').animate({width: "500%", height: "500%", opacity: "0.25"},
5000, function(){ $(this).fadeOut(2000);});
}

// alternative method
$('img').animate({width: "100%", height: "100%"}, 1000, function()
{$(this.fadeOUt() });
```  
##jQuery Effect  
[jQuery Effect](http://jqueryui.com/effect/)  
  
Add the jquery ui rails gem to your gemfile.  
```ruby
# Gemfile

# ...

gem 'jquery-ui-rails'

# ...
```  
Then require jquery ui in your application.css and application.js files  
```css
* app/assets/stylesheets/application.css
* ...
*= require jquery.ui.all
* ...
```  
```javascript
// app/assets/javascripts/application.js
// ...
//= require jquery.ui.all
// ...
```  
2.) Write a function that increases the size of an image 100%, bounces
it, then fades out.  
```javascript
var bigBounceFade = function() {
  $('img').animate({ width: "100%", height: "100%" }, 3000, function() {
$(this).effect("bounce", 5000, function(){$(this).fadeOut(2000);});});
  };
```  
More effects  
```javascript
$('img').draggable({stop: function(){alert("drag complete");});
```  
3.) Write some jQuery that makes the content of the div id="text" to be
"dragging" while you drag the image, and "done dragging" when you stop.   
```javascript
$('img').draggable({start: function(){
  $('body').find("#text").text("dragging")
  }, stop: function(){
    $('body').find("#text").text("done dragging");
    }
  });
```  
4.) You have a list. When you drag an item in the list, it fades away
and disappears. Try to create this using jQuery.  
```javascript
$('li').draggable({stop: function(){$(this).fadeOut();}});
```  
5.) Have a page with many randomly generated buttons, and when you click
on one, it generates a random [jQuery
Effect](http://jqueryui.com/effect/)    
```javascript  
  var buttonGenerator = function(n) {
    for(var i = 0; i < n; i++) {
      $('body').append('<button class="effect btn btn-primary">Click
Me</button>');
    }
  }
  buttonGenerator(Math.floor((Math.random()*100)+1));

  effects = [
    'blind',
    'bounce',
    'clip',
    'drop',
    'explode',
    'fade',
    'fold',
    'highlight',
    'puff',
    'pulsate',
    'scale',
    'shake',
    'size',
    'slide',
    'transfer'
    ]

  randomEffect = effects[Math.floor(Math.random() * effects.length)];

  $('.effect').on('click', function(){$(this).effect(randomEffect)});
```  
## CoffeeScript  

CoffeeScript has a ruby-like syntax. Like HAML, it is very case
sensitive, and there are times when errors can be vague. It is
case-sensitive, and whitespace sensitive. Try practicing using
[js2coffee](http://js2coffee.org/).      
  
```javascript
// JavaScript
var a, b, sayHello;

a = void 0;

b = void 0;

sayHello = void 0;

a = 10;

if (a > b) {
  b = 5;
}

sayHello = function(name) {
  return alert("hello there, " + name);
};

$("hello").on("click", function() {
  return $(this).fadeOut(1000, function() {
    return $(this).effect("shake");
  });
});

// CoffeeScript
a = undefined
b = undefined
sayHello = undefined
a = 10
b = 5  if a > b

sayHello = (name) ->
  alert "hello there, " + name

$("hello").on "click", ->
  $(this).fadeOut 1000, ->
    $(this).effect "shake"

```  
***note***: Comments in CoffeeScript use a hashtag ('#').  
Doing Document Ready in CoffeeScript uses the '$'.  Instead of function,
we use '->', and if we want to pass parameters, like function(myParam1,
myParam2), we can like '(myParam1, myParam2) ->' and instead of 'this'
we use '@'.
```javascript



```  
6.) Using coffee script, write some code so that when you click on a
button, it toggles 'btn-primary' and 'btn-danger'.  
```coffeescript
$ ->
  $(".btn").on "click", ->
    $(@).toggleClass("btn-primary").toggleClass("btn-danger")

```  
Loops and arrays in CoffeeScript  
```coffeescript
# coffeescript
array = [1, 2, 3, 4, 5]

multiply = (x) -> x * x

multiply x for x in array

// javascript
var array, multiply, x, _i, _len;

array = [1, 2, 3, 4, 5];

multiply = function(x) {
  return x * x;
};

for (_i = 0, _len = array.length; _i < _len; _i++) {
  x = array[_i];
  multiply(x);
}
```  
7.) Create a method in coffeescript that capitalizes the first letter of
each word in a string.  
```coffeescript
$ ->
  capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

  $("#my-input").on "keyup", ->
    word_array = $(@).val().split(" ")
    word_array = word_array.map (word) -> capitalize(word)
    $("#shuffled").text word_array.join(" ")
```  
We can define an object in CoffeeScript  
```coffeescript
cookie = 
    sugar: 5
    flour: 10
    calorieAmount: -> @.sugar * 5 + @.flour * 4
```  
8.) Write some code that changes the background color of your web site
every 2 seconds to a random color
```coffeescript
$ ->
  setInterval ->
    color1 = Math.floor Math.random() * 255
    color2 = Math.floor Math.random() * 255
    color3 = Math.floor Math.random() * 255
    $('body').css
    background: "rgb(" + color1 + ", " + color2 + ", " + color3 + ")"
  , 2000
```
# More Javascript  
[github repo](https://github.com/tkbeili/jquery_drills) |    
Form input validations.  
1.) Create an input form with two fields. One for email, and one for
password. If the email is not a valid format, show an x, otherwise show
a check. If the password is fewer than 8 characters, show an x,
otherwise show a check. Perform the check on focus out.  
```javascript

```  
2.) Use draggable and droppable. Make 4 boxes: 1 large and 3 small. The
small boxes should be draggable and droppable onto the large box.  
```javascript
$ ->
  $(".box").draggable()
  $("#drop-box").droppable
    drop: (event, ui)->
      alert("You dropped an Item with id: " +
$(ui.draggable).attr("id"));
```   
3.) Make a button that alternates between three classes on click:
"btn-danger", "btn-primary", and "btn-info".  
```javascript
$ ->
  classes = [""]
  currentIndex = 0
  $(".btn").on "click", ->
    $(@).toggleClass(classes[currentIndex])
    currentIndex = if currentIndx >= (classes.length-1) then 0 else
currentIndex + 1
    $(@).addClass classes[currentIndex]

```  
4.) Create a checkbox list that when you check items on the list, they
gain a strike-through.  
```haml
/ haml to generate the checkboxes
%ul{style: "" }
  - 10.times do |x|
    %li.checkbox
      %label
        = check_box_tag "box#{x}", "abc", nil, class: "chkbox"
        = "Check Box #{x}"
```    
```javascript
$('.chkbox').on "change", ->
  if @.checked
    $(@).parent().addClass("checked")
  else
    $(@).parent().removeClass("checked")
```  
```css
.checked { text-decoration: line-through; }
```
5.) Using the list you created in the previous exercise, add the
functionality so that items that are checked move to a "completed items"
div  
```javascript

$ ->
  $(".chkbox").on "change", ->
    if @.checked
      $(@).parent().addClass('checked')
      $li = $(@).parents "li"
      $li.fadeOut 500,
        $(@).appendTo ".completed"
        $(@).fadeIn 300
    else
      $(@).parent().removeClass("checked")
      $li = $(@).parents "li"
      li.fadeOut 300, ->
        $(@).appendTo ".pending"
        $(@).fadeIn 300
```
# Ajax  
  
To make your answer form on the question show view use AJAX, open up
simply add `remote: true` in the `form_for` line  
  
```haml
/ app/questions/views/show.html.haml
= form_for @answer, url: question_answers_path(@question), remote: true
do |f|
  = f.text_area :body, class: "form-control"
  %br
  = f.submit "Submit an answer", class: "btn btn-primary"
  %hr 

/ We can replace the following 
-#  -@question.answers.each do |answer|
-#    = render "/answers/answer", answer: answer

/ With this (because we will tell our answers_controller create method
to render some javascript): 
.answers= render @answers 
 ```  
 Then, inside the answers controller, let's look at the create method.
We can add a respond_to to give some format options.  
 ```ruby
 # app/controllers/answers_controller.rb
 
 # ...
 
   def create
    #@question = Question.find params[:question_id]
    @answer = @question.answers.new(answer_attributes)
    @answer.user_id = current_user
    respond_to do |format|
      if @answer.save
        # AnswerMailer.notify_question_owner(@answer).deliver
        AnswerMailer.delay.notify_question_owner(@answer)
        format.html { redirect_to @question, notice: "Answer created
successfully" }
        format.js   {render}  # here rails will look for a view of the
name of the method 'create.js.haml'
      else
        format.html { render "questions/show" }
        format.js   {render js: "alert('ERROR');"}
      end
    end
  end
  
# ...

```  
Now, if we change the line `format.js {render js: "alert('created');"}`
to just `format.js { render }` it will look for a create.js file. Let's
make one.  
```haml
/ app/views/answers/create.js.haml
$('#answer_body').val(""); 
  $('.answers').prepend("#{j render 'answer', answer: @answer}");
  $("##{dom_id(@answer)}").hide().fadeIn(500);
```  
If we want to prepend an answer to a div of class 'answers', we should
make sure this exists in our questions show view.  
```haml
/ app/views/questions/show.html.haml
.answers
  -@question.answers.each do |answer|
    = render "/answers/answer", answer: answer
```  
Add `.well{id: dom_id(answer)}` to the answers partial so each answer
has a dom id.  
```
/ app/views/answers/_answer.html.haml
.well{id: dom_id(answer)}  
  .row
    .col-sm-8.col-md-8.col-xs-8
      %p= answer.body      
      %p Created on #{formatted_date(answer.created_at)}
    .col-sm-4.col-md-4.col-xs-4
      .pull-right= button_to "Delete", question_answer_path(@question,
answer), method: :delete, confirm: "Are you sure you want to delete
this?", class: "btn btn-danger", remote: true
``` 
# quora-app
