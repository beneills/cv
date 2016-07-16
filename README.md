# CV [![Build Status](https://travis-ci.org/beneills/cv.svg?branch=gh-pages)](https://travis-ci.org/beneills/cv) [![Gratipay](https://img.shields.io/gratipay/beneills.svg)](https://www.gratipay.com/beneills/) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

_Generate a resumé of your Github activity!  See a live example [here](http://beneills.github.io/cv)._

## Why

In __five minutes__ you can show off your best public activity on Github, whether commits, pull requests, stats or conversations, and publish this online.  This means you can direct people towards the work you want to emphasize.  __With more time__, you can customize your resumé by changing basic HTML, adding whatever else you want to it.

![Screenshot of resumé](screenshot.png)


## Usage

```shell
# fork repository
git clone https://github.com/USERNAME/cv
cd cv
# apt-get install phantomjs or brew install phantomjs
bundle install
edit templates/index.html # or use the default
bundle exec rake
# use `bundle exec rake light` to skip downloading anything
open index.html
```

## Publishing

```shell
# on branch gh-pages
git commit -am 'Customize my resumé' && git push
open http://USERNAME.github.io/cv
```
If you manage to get a job using this, you should [give](https://www.gratipay.com/beneills/) me some money...

## Contributing

 - Create or take ownership of an issue
 - Fork _gh-pages_ branch
 - Write code
 - `bundle exec rake test`
 - `bundle exec rake release`
 - Commit [with a reasonable message](http://chris.beams.io/posts/git-commit/)
 - Push and possibly run [Travis](travis-ci.org/) on your fork
 - Submit a pull request
