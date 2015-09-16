class Board < ActiveRecord::Base
    belongs_to :member, class_name: "Member", foreign_key: "member_id"
    belongs_to :group, class_name: "Gg", foreign_key: "gg_id"
end
