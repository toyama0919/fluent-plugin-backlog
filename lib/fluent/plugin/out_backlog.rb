# -*- encoding : utf-8 -*-
module Fluent
  class Fluent::BacklogOutput < Fluent::BufferedOutput
    Fluent::Plugin.register_output('backlog', self)

    config_param :space, :string
    config_param :user, :string
    config_param :password, :string
    config_param :project_id, :string
    config_param :summary_template, :string
    config_param :summary_keys, :string, default: nil
    config_param :description_template, :string, default: nil
    config_param :description_keys, :string, default: nil
    config_param :component, :string, default: nil

    def initialize
      super
      require 'xmlrpc/client'
    end

    def configure(conf)
      super
      @server = XMLRPC::Client.new2("https://#{@user}:#{@password}@#{@space}.backlog.jp/XML-RPC")
      @summary_keys = @summary_keys.split(',')
      if @description_keys
        @description_keys = @description_keys.split(',')
      end
    end

    def start
      super
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      [tag, time, record].to_msgpack
    end

    def write(chunk)
      chunk.msgpack_each do |tag, time, record|
        summary = @summary_template % @summary_keys.map { |key| record[key] }
        args = { projectId: @project_id, summary: summary }
        if @description_template
          description = @description_template % @description_keys.map { |key| record[key] }
          args[:description] = description
        end
        args[:component] = @component if @component
        @server.call('backlog.createIssue', args)
      end
    end
  end
end
