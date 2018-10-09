class User < ApplicationRecord
  has_one_attached  :avatar
  has_many_attached :photos


  def after_active_storage_attach(data)
    pp data
  end

  def before_active_storage_attach(data)
    pp data
  end

end
