class Gg < ActiveRecord::Base
    belongs_to :user
    has_many :members
    has_many :boards
end
