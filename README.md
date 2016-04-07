## GithubCloner

Export/clone Github repository (public/private) by user or organization name

[![Gem Version](https://badge.fury.io/rb/github-cloner.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/github-cloner.png)][gemnasium]

[gem]: http://badge.fury.io/rb/github-cloner
[gemnasium]: https://gemnasium.com/agilecreativity/github-cloner

### Start with Why

- Be able to get grab all of interesting codes from a given user quickly
- Be able to clone specific language for a given user/organization
- Be able to clone all of organization/users in one go if desired
- Be able to clone private/public repositories for a given user/organization
- Be able to learn quickly or look at how something works from the source code
- I am too lazy to do this manually or through some other shell script

### Installation

```sh
# Install the gem
gem install github-cloner

# refresh your gem just in case
rbenv rehash

# Get list of options just type the name of the gem
github-cloner
```

You should see something like

```
Usage: github-cloner [options]

Specific options:
    -b, --base-dir BASE_DIR          where BASE_DIR is the directory where the repositories will be cloned to (mandatory)
                                     If not specified, current directory will be used
    -u, --user USER                  The Github USER that will be cloned from (mandatory)
    -o, --org [ORG]                  The Github's organization name to be used if specified (optional)
                                     where ORG is the organization that the user belongs to
    -t, --oauth-token [OAUTH_TOKEN]  The Github's oauth_token for authentication (optional - only required to list/clone private repositories)
                                     where OAUTH_TOKEN is from the user's Github setting
    -l, --language [LANG]            Clone only project of type LANG (optional)
                                     where LANG is main language as shown on Github
    -a, --[no-]all-repos             All repository only (optional)
                                     default to original/non-forked repositories only
    -g, --[no-]group-by-user         Group the output by {BASE_DIR}/{USER}/{LANG}
                                     default to {BASE_DIR}/{LANG}/{USER}
    -c, --[no-]clone                 Clone the repositories to the path specified (optional)
                                     default to --no-clone e.g. dry-run only

Common options:
    -h, --help                       Show this message
```

- List repositories by user or organization id

```sh
# List all original/non-forked repositories by `awesome_user`
$github-cloner --user awesome_user

## List all original/non-forked repositories of a user `awesome_user` that belongs to `AwesomeCo`
$github-cloner --user awesome_user --org AwesomeCo

## List all origina/non-forked repositories by user `awesome_user` including private repository
# Note: for this to work you will need to have the proper access with the right token
$github-cloner --user awesome_user --oauth-token GITHUB_TOKEN_FOR_THIS_USER

## List all repositories by user `awesome_user` include forked repositories
$github-cloner --user awesome_user --oauth-token GITHUB_TOKEN_FOR_THIS_USER
```

- List and clone repositories by user or organization id using `--clone` option

```sh
## Clone all original (non-fork) public `JavaScript` repositores for user `awesome_user` to `~/Desktop/github`
# Note: --base-dir is optional, if not specified then the current directory will be used
#       --languages must be quoted if the value include any spaces e.g. "Emacs Lisp" for this to to work properly
$github-cloner --user awesome_user \
               --base-dir ~/Desktop/github \
               --languages "JavaScript" \
               --clone

## Clone all public/private repositories for `awesome_user` which are member of `AwesomeCo` organization to `~/Desktop/github`
# Note: the option `--all` to include all forked repositories
$github-cloner --user awesome_user \
               --org AwesomeCo \
               --all-repos \
               --base-dir ~/Desktop/github \
               --oauth-token GITHUB_TOKEN_FOR_AWESOME_USER \
               --clone

## Clone specific type of projects (e.g. `Java` and `Emacs Lisp` in this case) public/private repositories for `awesome_user`
## which are member of `AwesomeCo` organization to `~/Desktop/github`
$github-cloner --user awesome_user \
               --org AwesomeCo \
               --all-repos \
               --languages "Java,Emacs Lisp" \
               --base-dir ~/Desktop/github \
               --oauth-token GITHUB_TOKEN_FOR_AWESOME_USER \
               --clone
```

### Example Sessions

- List repositories by a given user (dry-run)

```
$github-cloner -b ~/Desktop/projects -u littlebee -l Ruby
------------------------------------------
List of languages by littlebee
Makefile
CoffeeScript
Ruby
JavaScript
Arduino
------------------------------------------
------------------------------------------
List of all repositories by littlebee
1/15: littlebee/Makefile/arduino-mk
2/15: littlebee/CoffeeScript/bumble-build
3/15: littlebee/CoffeeScript/bumble-docs
4/15: littlebee/CoffeeScript/bumble-strings
5/15: littlebee/CoffeeScript/bumble-test
6/15: littlebee/CoffeeScript/bumble-util
7/15: littlebee/CoffeeScript/git-log-utils
8/15: littlebee/CoffeeScript/git-status-utils
9/15: littlebee/CoffeeScript/git-time-machine
10/15: littlebee/CoffeeScript/notjs
11/15: littlebee/CoffeeScript/publish
12/15: littlebee/CoffeeScript/react-focus-trap-amd
13/15: littlebee/Ruby/got
14/15: littlebee/JavaScript/selectable-collection
15/15: littlebee/Arduino/solar-sunflower
------------------------------------------
FYI: dry-run only, no action taken!!
Process 1 of 1 : git clone git@github.com:littlebee/got.git /Users/bchoomnuan/Desktop/projects/Ruby/littlebee/got
```

- List and clone repositories for a given user (e.g. `--clone` option used)

```
$github-cloner -b ~/Desktop/projects -u littlebee -l Ruby -c
------------------------------------------
List of languages by littlebee
Makefile
CoffeeScript
Ruby
JavaScript
Arduino
------------------------------------------
------------------------------------------
List of all repositories by littlebee
1/15: littlebee/Makefile/arduino-mk
2/15: littlebee/CoffeeScript/bumble-build
3/15: littlebee/CoffeeScript/bumble-docs
4/15: littlebee/CoffeeScript/bumble-strings
5/15: littlebee/CoffeeScript/bumble-test
6/15: littlebee/CoffeeScript/bumble-util
7/15: littlebee/CoffeeScript/git-log-utils
8/15: littlebee/CoffeeScript/git-status-utils
9/15: littlebee/CoffeeScript/git-time-machine
10/15: littlebee/CoffeeScript/notjs
11/15: littlebee/CoffeeScript/publish
12/15: littlebee/CoffeeScript/react-focus-trap-amd
13/15: littlebee/Ruby/got
14/15: littlebee/JavaScript/selectable-collection
15/15: littlebee/Arduino/solar-sunflower
------------------------------------------
Process 1 of 1 : git clone git@github.com:littlebee/got.git /Users/bchoomnuan/Desktop/projects/Ruby/littlebee/got
```

### TODO

- Replace system call with the ruby library like [grit](https://github.com/mojombo/grit) or something similar
- Allow the `https` when performing the clone

### Related Projects

- [github_cloner](https://github.com/nashby/github_cloner) by Vasiliy Ermolovich

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[Thor]: https://github.com/erikhuda/thor
[Minitest]: https://github.com/seattlerb/minitest
[RSpec]: https://github.com/rspec
[Guard]: https://github.com/guard/guard
[Yard]: https://github.com/lsegal/yard
[Pry]: https://github.com/pry/pry
[Rubocop]: https://github.com/bbatsov/rubocop
