require 'relates_to'
require 'relationship'

ActiveRecord::Base.send :include, ActiveRecord::RelatesTo
