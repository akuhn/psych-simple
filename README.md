# psych-simple

Parse yaml 2-5x faster, using a simplified (and safe) file format

- All values are deserialized as strings
- Anchors and tags are not accepted
- Ruby objects not accepted

## Installation

Add this line to your application's Gemfile:

    gem 'psych-simple'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install psych-simple

## Usage

    require 'psych'
    require 'psych/simple'

    document = Psych.simple_load(File.open('example.yaml'))
