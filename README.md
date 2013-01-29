# RailsFinder

Finds Rails applications in a given directory and reports their version numbers.

Currently, I maintain quite a lot of Rails applications, and the recent flux of
security vulnerabilities left me wanting something a little more than one-off
shell scripts. I also felt like hacking on some Ruby that wasn't Rails, as it's
been a while since I've been able to. It felt good.

## Installation

    gem install rails_finder

## Usage

To search in the current directory

    $ find_rails

To specify a directory

    $ find_rails path_to_search

Example

    $ find_rails ~/code
    the-oldtimer      2.3.16   /Users/chris/code/the-oldtimer
    the-outlier       3.2      /Users/chris/code/the-outlier
    the-good-one      3.2.11   /Users/chris/code/the-good-one
    wat               4.0.0    /Users/chris/code/wat
    templates         n/a      /Users/chris/code/rails/railties/lib/rails/generators/rails/app/templates

## Limitations

* Only the Gemfile and config/environments.rb files are inspected. If the
  version specified there is not the installed version, then the report will be
  inaccurate. For example: `~> 3.2` will be reported as "3.2" regardless of the
  installed version.

* The recursive search will pick up config files of dummy applications that are
  only used for testing.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
