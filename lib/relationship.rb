class Relationship < ActiveRecord::Base
  belongs_to :relator, :polymorphic => true
  belongs_to :related, :polymorphic => true
  
  def self.add_relator(model)
    belongs_to ("relator_" + model.to_s.underscore).to_sym, :class_name => model.to_s, :foreign_key => "relator_id"
  end
  
  def self.add_related(model)
    belongs_to ("related_" + model.to_s.underscore).to_sym, :class_name => model.to_s, :foreign_key => "related_id"
  end
  
  def self.make_between(relator,related,options = {})
    self.create(:relator_id => relator.id,
                :relator_type => relator.class.to_s,
                :related_id => related.id,
                :related_type => related.class.to_s,
                :nature => options[:nature])
  end
  
  validate :source_and_target, :relationship_allowed
  
  protected
  
  def source_and_target
    errors.add_to_base("#{relator.class.to_s} is not a valid relationship source") unless respond_to?("relator_#{relator.class.to_s.underscore}")
    errors.add_to_base("#{related.class.to_s} is not a valid relationship target") unless respond_to?("related_#{related.class.to_s.underscore}")
  end
  
  def relationship_allowed
    errors.add_to_base("#{relator} is not permitted to relate to #{related}") unless related.can_relate?(relator, :as => nature)
  end
end