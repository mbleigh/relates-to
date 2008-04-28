module ActiveRecord
  module RelatesTo
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def relates_to(plural_model_name, options = {})
        Relationship.add_related(plural_model_name.to_s.singularize.classify)
        has_many :relator_relationships, :conditions => {:relator_type => self.to_s}, 
                                         :foreign_key => "relator_id",
                                         :class_name => "Relationship"
        has_many plural_model_name, :through => :relator_relationships, 
                                    :source => "related_#{plural_model_name.to_s.underscore.singularize}", 
                                    :conditions => ["relationships.relator_type = ?", self.to_s.singularize.camelize]
        include ActiveRecord::RelatesTo::RelatorMethods
      end
      
      def has_related(plural_model_name, options = {})
        Relationship.add_relator(plural_model_name.to_s.singularize.classify)
        has_many :related_relationships, :conditions => {:related_type => self.to_s}, 
                                         :foreign_key => "related_id",
                                         :class_name => "Relationship"
        has_many plural_model_name, :through => :related_relationships, 
                                    :source => "relator_#{plural_model_name.to_s.underscore.singularize}", 
                                    :conditions => ["relationships.related_type = ?", self.to_s.singularize.camelize]
        include ActiveRecord::RelatesTo::RelatedMethods                                 
      end
    end
    
    module RelatorMethods
      def relates_to(some_object, options={})
        relationship_options = {:nature => options[:as]}
        Relationship.make_between(self,some_object,options)
      end
    end
    
    module RelatedMethods
      def can_relate?(some_object, options = {})
        true
      end
    end
  end
end
