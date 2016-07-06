class Hotel < ActiveRecord::Base

  include ActsAsConstrained::Concerns::Constrained

  constrain_by :model
  constrain_by :date, optional: true

end
