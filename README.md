# Vuash

Vuash is a simple web app that enables you to share message through single access link.

Basically, Vuash encript your message and doesnt save any secret key on database, by this way
Event if we access the data inside datase we couldnt decript it.

> 1. Vuash receives message
> 2. Vuash encripts message on the fly with a secret
> 3. Vuash returns a link to access the message and discard the secret key
> 4. When message is accessed Vuash destroy
> 5. When trying to accessing message again, nothing is found


## Running it locally

```shell
$ git clone git@github.com:oicurrent/vuash.git
$ cd vuash
$ bundle install
$ rake migrate
$ shotgun
$ open http://localhost:9393
```
