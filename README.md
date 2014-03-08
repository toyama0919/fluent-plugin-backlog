# fluent-plugin-backlog, a plugin for [Fluentd](http://fluentd.org) [![Build Status](https://secure.travis-ci.org/toyama0919/fluent-plugin-backlog.png?branch=master)](http://travis-ci.org/toyama0919/fluent-plugin-backlog)

output plugin for Backlog.

## Installation

### td-agent(Linux)

    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-backlog

### td-agent(Mac)

    sudo /usr/local/Cellar/td-agent/1.1.XX/bin/fluent-gem install fluent-plugin-backlog

### fluentd only

    gem install fluent-plugin-backlog

## Parameters

param|value
--------|------
space|name space
user|user
password|password
project_id|project_id
summary_template|summary(sprintf)
summary_keys|summary key
description_template|description(sprintf format)
description_keys|description key
component|category_id

## Configuration Example(bulk insert)

```
<match backlog>
  type backlog
  space toyama0919
  user toyama0919
  password hogehoge
  project_id 1761
  summary_template %s
  summary_keys code
  description_template %s_%s
  description_keys code,host
  component bug
</match>
```



## spec

```
bundle install
rake test
```

## todo

update

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Hiroshi Toyama. See [LICENSE](LICENSE) for details.
