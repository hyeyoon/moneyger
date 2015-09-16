class MoneygerController < ApplicationController
     before_action :authenticate_user!
    
    def index
        @group = Gg.find_by_id(params[:id])
        @g = Gg.where(user_id: current_user.id)
    end
      
    def dashboard
        @u = User.all
        @g = Gg.where(user_id: current_user.id)
    end

    def mygroup   
    end
    
    def mymember
        m = Member.new
        m.tname = params[:tname]
        m.tnumber = params[:tnumber]
        m.gg_id = params[:g_id]
        m.save
        redirect_to '/moneyger/index/' + params[:g_id]
    end
    
    
    def mypage
    end
    
    def a1 
        @group = Gg.find_by_id(params[:id])
    end
    
    
    def a2
        @group = Gg.find_by_id(params[:id])
    end
    
    def test
        g = Gg.new
        g.gname = params[:gname] 
        g.total = params[:total]
        g.leader = params[:leader]
        g.account_number = params[:account_number]
        g.user_id = current_user.id
        g.save
        redirect_to '/'
    end
    
    def board
        group = Gg.find_by_id(params[:gg_id])
        
        p = Board.new
        p.date = params[:date]
        p.board_type = params[:board_type]
        p.content = params[:content]
        p.howmuch = params[:howmuch]
        p.remain = group.total - params[:howmuch].to_i
        
        group.total = p.remain # update total by remain
        group.save
        
        p.gg_id = group.id
        p.member_id = params[:member]
        p.save
        
        redirect_to '/moneyger/index/' + params[:gg_id]
    end
  
end
