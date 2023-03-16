# Farfetch

## 🛠️ Requirements
![ruby](https://img.shields.io/badge/Ruby-3.2.0-e62b12?style=flat&logo=ruby&logoColor=e62b12)
![rails](https://img.shields.io/badge/Ruby_on_Rails-v7.0.4-e62b12?style=flat&logo=ruby-on-rails&logoColor=e62b12)
![postgre](https://img.shields.io/badge/PostgreSQL-v13-4169E1?style=flat&logo=PostgreSQL&logoColor=black)
![redis](https://img.shields.io/badge/Redis--e62b12?&style=flat&logo=redis&logoColor=e62b12)

## ⚙️ Building
### Without Docker
1. Duplicate the `.env.sample` file and rename to `.env`
2. Run `bundle install`
3. Run `rails db:create db:migrate`
6. To up server run `rails server`
7. To run all tests run `rspec spec` or  `NO_COVERAGE=1 rspec spec` to run without coverage
8. To check coverage run `xdg-open coverage/index.html `
9. To check quality assurance, run: `./bin/qa`

### With Docker
1. Duplicate the `.env.sample` file and rename to `.env`
2. to build the images: `docker-compose build`
3. to up server `docker-compose up`
4. to run all rspec tests `docker-compose run --rm farfetch rspec`
5. to run rubocop `docker-compose run --rm farfetch rubocop`
6. to run reek `docker-compose run --rm farfetch reek`
6. to run brakeman `docker-compose run --rm farfetch brakeman`


## ✒️ About the challenge

A client needs to know what is happening on the social networks. All of them. Right now. The three social networks the client is interested in are:

https://takehome.io/twitter

https://takehome.io/facebook 

https://takehome.io/instagram

Because these social networks are so webscale, they don't always respond predictably. The delay in their response almost appears like someone waited for a random integer of seconds before responding!

Also, sometimes they will respond with an error. This error will not be valid JSON. Life's hard sometimes.

The client needs to be able to run your thing, then issue the command:

curl localhost:3000

And get back a JSON response of the output from the three social networks in the format:

{ twitter: [tweets], facebook: [statuses], instagram: [photos] }

Order isn't important.

This should be a quick little task, but the client is paying us A Billion dollars for it so make sure your implementation is as robust as it is beautiful. In other words this submission should be representative of the code you would produce for a production, live 24x7 system, we suggest you include documentation, test coverage, robust error handling. You should also be thinking about how to make this code perform as fast as possible.

