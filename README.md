#FGSF Contacts

This RoR app is used for maintaining contacts for FGSF group. 
Access to URL endpoints are protected behind admin roles.

###Basics
Link to[Github project](https://github.com/jparkSF/fgsf_contacts) for fgsf_contacts

    Ruby version: 2.3.1
    Ruby on Rails version: 4.2.6

###Prerequisite
1) Install RVM
2) Install Bundler
3) Clone the repo and `bundle install`

###Initialization
Set up MySQL server and rake it. Repo contains initial seed data with KM contacts.

    rake db:create
    rake db:migrate
    rake db:seed

###Pull Request
All code changes go through Pull Requests (**PR**) before being merged to master.

    git checkout -b new_branch
    # make changes
    git commit -am 'added new feature'
    git push
    # Go to https://github.com/jparkSF/fgsf_contacts and create a new PR for your branch
    # Once approved, merge to master through web UI.

###URL endpoints:
    /users/sign_up
    /users/sign_in
    /contacts
    /contacts/*
    /km
    /km/roles
    /km/birthdays

###Deploying
    ./script/deploy.sh
On server, an alias has been set up with `deploy_test` and `deploy_prod` for convenient deploy process.

###Secrets
Secrets are configured and stored by server administrator. To add new secrets, talk to an admin.

###Test
Not Available

###Rubocop (code analyzer)
Rubocop is a Ruby static code analyzer. It detects and encourages proper use and styling of Ruby code.

**Detect and show violations:**
```
rubocop
```
**Automatically fix all violations:**
```
robucop -a
```
(ie: `frozen_string_litelral: true` are automatically added by rubocop [Link](https://blog.lucascaton.com.br/2016/01/19/what-is-frozen_string_literal-in-ruby/))

####`Authored by: Jiwoo Park, Yonghyun Kim, Hojin Lee`
