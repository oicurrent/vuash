# Vuash

Vuash is a simple web app that lets you share messages through single access link.

We encrypt your message without storing any secret key in the database. This ensures that we do not have access to your message.


## Technical Steps

1. Vuash receives message
2. Vuash encrypts message on the fly with a secret key
3. Vuash returns a link to access the message and discards the secret key
4. When message is accessed, Vuash destroys it
5. When trying to access a message for a second time, nothing is found


## Running it locally

```shell
$ git clone git@github.com:oicurrent/vuash.git
$ cd vuash
$ bundle install
$ rake migrate
$ shotgun
$ open http://localhost:9393
```
