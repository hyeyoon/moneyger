class MoneygerController < ApplicationController
     before_action :authenticate_user!, :except => [:index]
    
    def index
        @group = Gg.find_by_id(params[:id])
        @g = Gg.where(user_id: current_user.id)
        members = @group.members.all
        boards = @group.boards.all
        
        @pig = 0
        boards.each do |b|    
            if b.board_type == 'ONLY'
                @pig += b.howmuch
            end
        end    
        
        @current = {}
        @usage = {}
            
        @total_remains = @group.total
        
        @members = members
        
        if members.length > 0
            total_money = @total_remains
            common_money = total_money / members.length
            
            # common shared money
            members.each do |m|
                @current[m.tname] = common_money
                @usage[m.tname] = 0
            end
            
            if boards.length > 0
                # board money
                boards.each do |b, idx|
                    if b.board_type == 'GROUP'
                        members.each do |m|
                            @current[m.tname] = @current[m.tname] - b.howmuch / members.length
                            @usage[m.tname] = b.howmuch / members.length
                        end
                    elsif b.board_type == 'ONLY' and b.member
                        @current[b.member.tname] = @current[b.member.tname] - b.howmuch
                        @usage[b.member.tname] = @usage[b.member.tname] + b.howmuch
                    elsif idx == boards.length
                        @total_remains = b.remain
                    end
                    
                end
            end    
        end
       
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
        
        latest_board = Board.where(gg_id: params[:gg_id]).order(:id => :desc).take
        p = Board.new
        p.date = params[:date]
        p.board_type = params[:board_type]
        
        
        p.content = params[:content]
        p.howmuch = params[:howmuch]
        
        if group.boards.all.empty?
           p.remain = group.total - params[:howmuch].to_i
        else
            p.remain = latest_board.remain - params[:howmuch].to_i
        end
     
        #p.remain = group.total - params[:howmuch].to_i
        #p.remain = latest_board.remain - params[:howmuch].to_i
        p.gg_id = group.id
        p.member_id = params[:member]
        p.save
       
        redirect_to '/moneyger/index/' + params[:gg_id]
    end
    def modify
        @postmodify = Gg.find_by_id(params[:id])
    
    end

    def updatem
        one_post = Gg.find_by_id(params[:id])
        one_post.gname = params[:new_gname]
        one_post.leader = params[:new_leader]
        one_post.account_number = params[:new_account_number]
        one_post.total = params[:new_total]
        one_post.save
        
        redirect_to '/'
    end
    
    def delete
        d_gg = Gg.find_by_id(params[:id]) # id -> group_id
        d_gg.destroy
        redirect_to '/'
    end
    
    def delete_member
        d_mm = Member.find_by_id(params[:id]) # id ->member_id
        group_id = d_mm.gg_id
        d_mm.destroy
        redirect_to :controller => 'moneyger', :action => 'index', :id => group_id
    end
    
end