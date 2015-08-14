class Offer < ActiveRecord::Base

  include ActsAsConstrained::Concerns::Constrained

  constrain_by :date
  constrain_by :single_date
  constrain_by :model

end
