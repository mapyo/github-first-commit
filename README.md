github-first-commit
===================

This, You can get the latest commit log.
If, if it is a pull request, the name and title and URL will be displayed.

## Requirement
* ruby

## Usage
```
# for github
$ curl -s https://raw.githubusercontent.com/mapyo/github-first-commit/v1.1/latest_commits.rb | REPO_PATH=rails/rails/ ruby
The most recent commit is [ci skip] ActionView and ActionMailerCHANGELOG docs fixes https://github.com/rails/rails/pull/16953 by Abdelkader Boudih.

#for ghe
$ curl -s https://raw.githubusercontent.com/mapyo/github-first-commit/v1.1/latest_commits.rb | REPO_PATH=owner/repo/ GHE_URL=http://hostname/ TOKEN=hogehogehogehogehogehogehogehogehogehoge ruby
The most recent commit is hoge http://hostname/owner/repo/pull/13 by hoge.
```

```
# shellscript
export REPO_PATH="owner/repo/"
export GHE_URL="http://hostname/"
export TOKEN="hogehogehogehogehogehogehogehogehogehoge"
MESSAGE=`curl -s https://raw.githubusercontent.com/mapyo/github-first-commit/v1.1/latest_commits.rb | ruby`
echo $MESSAGE
```
