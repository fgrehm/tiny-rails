class SampleModel
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :password

  validates :password, :confirmation => true

  # Required to use this model in a form builder
  def persisted?
    false
  end
end
