require 'helper'

class BacklogOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf = CONFIG, tag = 'test')
    Fluent::Test::BufferedOutputTestDriver.new(Fluent::BacklogOutput, tag).configure(conf)
  end

  def test_configure_error
    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        user toyama0919
        password hogehoge
        project_id 1111
        summary_template %s
        summary_keys code
        description_template %s_%s
        description_keys code,host
        component bug
      ]
    end

    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        space toyama0919
        password hogehoge
        project_id 1111
        summary_template %s
        summary_keys code
        description_template %s_%s
        description_keys code,host
        component bug
      ]
    end

    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        space toyama0919
        user toyama0919
        password hogehoge
        project_id 1111
        description_template %s_%s
        description_keys code,host
        component bug
      ]
    end
  end

  def test_configure
    # not define format(default csv)
    assert_nothing_raised(Fluent::ConfigError) do
      d = create_driver %[
        space toyama0919
        user toyama0919
        password hogehoge
        project_id 1111
        summary_template %s
        summary_keys code
        description_template %s_%s
        description_keys code,host
        component bug
      ]
    end

    assert_nothing_raised(Fluent::ConfigError) do
      d = create_driver %[
        space toyama0919
        user toyama0919
        password hogehoge
        project_id 1111
        summary_template %s
        summary_keys code
        description_template %s_%s
        description_keys code,host
        component bug
      ]
    end

    assert_nothing_raised(Fluent::ConfigError) do
      d = create_driver %[
        space toyama0919
        user toyama0919
        password hogehoge
        project_id 1111
        summary_template %s
        summary_keys code
      ]
    end

    assert_nothing_raised(Fluent::ConfigError) do
      d = create_driver %[
        space toyama0919
        user toyama0919
        password hogehoge
        project_id 1111
        summary_template %s
        summary_keys code
        description_template %s_%s
        description_keys code,host
      ]
    end
  end
end
