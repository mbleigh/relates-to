require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

load(File.dirname(__FILE__) + '/schema.rb')

class RelatableUser < ActiveRecord::Base
  relates_to :relatable_forums, :as => [:administrator, :moderator]
end

class RelatableForum < ActiveRecord::Base
  has_related :relatable_users, :as => [:administrator, :moderator]
end