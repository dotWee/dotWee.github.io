# [dotwee.github.io](https://dotwee.github.io/)

[![Jekyll Build & Deploy](https://github.com/dotWee/dotWee.github.io/actions/workflows/main.yml/badge.svg)](https://github.com/dotWee/dotWee.github.io/actions/workflows/main.yml)

_a simple static website* built using [jekyll](https://jekyllrb.com/) and some handcrafted stylesheets_

<sub>* /(personal|webbased|cv-letter|resume)/g</sub>
</br>

## setup

### manually

1. install a full [ruby development environment](https://jekyllrb.com/docs/installation/)
2. install [jekyll](https://jekyllrb.com/) and [bundler](https://jekyllrb.com/docs/ruby-101/#bundler) [gems](https://jekyllrb.com/docs/ruby-101/#gems):

    ```bash
    $ gem install jekyll bundler --user-install
    ```

3. clone git repository and change into repo directory:

    ```bash
    $ git clone https://github.com/dotWee/dotWee.github.io.git dotwee-github-io && cd dotwee-github-io
    ```

### through [devcontainer](https://containers.dev/)

open this repository in a devcontainer-supported-ide (like visual studio code or [GitHub Codespace](https://docs.github.com/codespaces)):

1. clone git repository and change into repo directory:

    ```bash
    $ git clone https://github.com/dotWee/dotWee.github.io.git dotwee-github-io && cd dotwee-github-io
    ```

2. open the git repository in Visual Studio Code & install the Remote-Containers extension
3. Visual Studio Code will detect the devcontainer configuration and prompt you to reopen the project in a devcontainer: click on "_Reopen in Container_" and you're done

## usage

### run site locally using [jekyll](https://jekyllrb.com/)

1. install required dependencies:

    ```bash
    $ bundle install
    ```

2. build the site and make it available on a local server:

    ```bash
    $ bundle exec jekyll serve
    ```

3. now browse to [localhost:4000](http://localhost:4000)

### run site using [docker](https://www.docker.com/)

```bash
$ docker run --rm \
    --name dotwee-github-io \
    -p 4000:4000 \
    --volume="$PWD:/srv/jekyll" \
    -it jekyll/jekyll:latest \
    jekyll serve --force_polling --livereload
```

alternatively using [docker-compose](https://docs.docker.com/compose):

> **note**: see [./compose.yml](./compose.yml) for reference

```bash
$ docker compose up -d
```

### update [ruby gems](https://rubygems.org/) dependencies

```bash
$ bundle update
```

### cleanup binaries

```bash
$ bundle exec jekyll clean
```

## links & references

this resume makes use of the json resume schema by [jsonresume](https://jsonresume.org/).


## license

copyright (c) 2015 lukas 'dotwee' wolfsteiner <lukas@wolfsteiner.media>

licensed under the [_do what the fuck you want to_](/LICENSE) public license
