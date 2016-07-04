# PicNamer

Renames all yo JPEGs.

## Installation

Add this line to your application's Gemfile:

    gem 'pic_namer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pic_namer

## Usage

You should be able to run this using the bin/name_pics.rb script, like so:

    $ ruby -Ilib ./bin/name_pics.rb ~/Pictures/test test jpg
    
where:
* "~/Pictures/test" is the directory containing the pictures
* "test" is the new prefix to put on the files
* "jpg" is the extension to use for the new files (defaults to "jpg")
