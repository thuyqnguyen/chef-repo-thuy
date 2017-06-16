actions :create
default_action :create

attribute :path, :kind_of => String, :name_attribute => true
attribute :content, :kind_of => String

attr_accessor :exists
