class MatchesController < ApplicationController
  before_action :authenticate_user!
  def dashboard
    @current_match = Match.where(user1Id: current_user.id).where.not(status: 'archived').first
    @current_match = Match.where(user2Id: current_user.id).where.not(status: 'archived').first if @current_match == nil

    if @current_match == nil #user logs in after sunday and all old matches have been archived
      make_match
    elsif @current_match.status=='finished'
      match_found
    else
      match_not_found
    end
  end

  def make_match
    @day_of_week = Time.now.wday # sunday = 0, monday = 1, ...
    render 'make_match'
  end

  def match_found
    if stale? (@current_match)
      @other_user = @current_match.user1Id == current_user.id ? User.find(@current_match.user2Id) : User.find(@current_match.user1Id)

      if @current_match.mondayStartTime != nil
        @mondayStartTime = minutesToTime(@current_match.mondayStartTime)
        @mondayEndTime = minutesToTime(@current_match.mondayEndTime)
      end
      if @current_match.tuesdayStartTime != nil
        @tuesdayAvailable = true
        @tuesdayStartTime = minutesToTime(@current_match.tuesdayStartTime)
        @tuesdayEndTime = minutesToTime(@current_match.tuesdayEndTime)
      end
      if @current_match.wednesdayStartTime != nil
        @wednesdayAvailable = true
        @wednesdayStartTime = minutesToTime(@current_match.wednesdayStartTime)
        @wednesdayEndTime = minutesToTime(@current_match.wednesdayEndTime)
      end
      if @current_match.thursdayStartTime != nil
        @thursdayAvailable = true
        @thursdayStartTime = minutesToTime(@current_match.thursdayStartTime)
        @thursdayEndTime = minutesToTime(@current_match.thursdayEndTime)
      end
      if @current_match.fridayStartTime != nil
        @fridayAvailable = true
        @fridayStartTime = minutesToTime(@current_match.fridayStartTime)
        @fridayEndTime = minutesToTime(@current_match.fridayEndTime)
      end
      if @current_match.saturdayStartTime != nil
        @saturdayStartTime = minutesToTime(@current_match.saturdayStartTime)
        @saturdayEndTime = minutesToTime(@current_match.saturdayEndTime)
      end
      if @current_match.sundayStartTime != nil
        @sundayAvailable = true
        @sundayStartTime = minutesToTime(@current_match.sundayStartTime)
        @sundayEndTime = minutesToTime(@current_match.sundayEndTime)
      end

      @cuisines_list = Array.new
      MatchToFood.where(matchId: @current_match.id).find_each do |match_to_food|
        @cuisines_list << Food.where(id: match_to_food.foodId).first.name
      end

      render 'match_found'
    end
  end

  def match_not_found
    if stale? (@current_match)
      @status = @current_match.status

      if @current_match.mondayStartTime != nil
        @mondayStartTime = minutesToTime(@current_match.mondayStartTime)
        @mondayEndTime = minutesToTime(@current_match.mondayEndTime)
      end
      if @current_match.tuesdayStartTime != nil
        @tuesdayAvailable = true
        @tuesdayStartTime = minutesToTime(@current_match.tuesdayStartTime)
        @tuesdayEndTime = minutesToTime(@current_match.tuesdayEndTime)
      end
      if @current_match.wednesdayStartTime != nil
        @wednesdayAvailable = true
        @wednesdayStartTime = minutesToTime(@current_match.wednesdayStartTime)
        @wednesdayEndTime = minutesToTime(@current_match.wednesdayEndTime)
      end
      if @current_match.thursdayStartTime != nil
        @thursdayAvailable = true
        @thursdayStartTime = minutesToTime(@current_match.thursdayStartTime)
        @thursdayEndTime = minutesToTime(@current_match.thursdayEndTime)
      end
      if @current_match.fridayStartTime != nil
        @fridayAvailable = true
        @fridayStartTime = minutesToTime(@current_match.fridayStartTime)
        @fridayEndTime = minutesToTime(@current_match.fridayEndTime)
      end
      if @current_match.saturdayStartTime != nil
        @saturdayStartTime = minutesToTime(@current_match.saturdayStartTime)
        @saturdayEndTime = minutesToTime(@current_match.saturdayEndTime)
      end
      if @current_match.sundayStartTime != nil
        @sundayAvailable = true
        @sundayStartTime = minutesToTime(@current_match.sundayStartTime)
        @sundayEndTime = minutesToTime(@current_match.sundayEndTime)
      end

      @cuisines_list = Array.new
      MatchToFood.where(matchId: @current_match.id).find_each do |match_to_food|
        @cuisines_list << Food.where(id: match_to_food.foodId).first.name
      end

      render 'match_not_found'
    end
  end

  def match_request
    # check if user already submitted a request
    user1_matches = Match.not_archived.with_user1(current_user.id.to_s).size
    user2_matches = Match.not_archived.with_user2(current_user.id.to_s).size
    if user1_matches > 0 || user2_matches > 0
      return head(:bad_request)
    end

    # get all pending matches, from same school, and with at least one food in common
    matches = Match.pending.with_school(current_user.school).with_foods(params[:cuisines])

    # get a match that at least has one time in common
    picked_match = nil
    matches.each do |match|
      if match.mondayStartTime != nil && params[:mondayAvailable] == 'true'
        if match.mondayStartTime == params[:mondayTimes][0].to_i
          picked_match = match
          break
        end
        if match.mondayStartTime < params[:mondayTimes][0].to_i && match.mondayEndTime > params[:mondayTimes][0].to_i
          picked_match = match
          break
        end
        if match.mondayStartTime > params[:mondayTimes][0].to_i && match.mondayStartTime < params[:mondayTimes][1].to_i
          picked_match = match
          break
        end
      end
      if match.tuesdayStartTime != nil && params[:tuesdayAvailable] == 'true'
        if match.tuesdayStartTime == params[:tuesdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.tuesdayStartTime < params[:tuesdayTimes][0].to_i && match.tuesdayEndTime > params[:tuesdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.tuesdayStartTime > params[:tuesdayTimes][0].to_i && match.tuesdayStartTime < params[:tuesdayTimes][1].to_i
          picked_match = match
          break
        end
      end
      if match.wednesdayStartTime != nil && params[:wednesdayAvailable] == 'true'
        if match.wednesdayStartTime == params[:wednesdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.wednesdayStartTime < params[:wednesdayTimes][0].to_i && match.wednesdayEndTime > params[:wednesdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.wednesdayStartTime > params[:wednesdayTimes][0].to_i && match.wednesdayStartTime < params[:wednesdayTimes][1].to_i
          picked_match = match
          break
        end
      end
      if match.thursdayStartTime != nil && params[:thursdayAvailable] == 'true'
        if match.thursdayStartTime == params[:thursdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.thursdayStartTime < params[:thursdayTimes][0].to_i && match.thursdayEndTime > params[:thursdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.thursdayStartTime > params[:thursdayTimes][0].to_i && match.thursdayStartTime < params[:thursdayTimes][1].to_i
          picked_match = match
          break
        end
      end
      if match.fridayStartTime != nil && params[:fridayAvailable] == 'true'
        if match.fridayStartTime == params[:fridayTimes][0].to_i
          picked_match = match
          break
        end
        if match.fridayStartTime < params[:fridayTimes][0].to_i && match.fridayEndTime > params[:fridayTimes][0].to_i
          picked_match = match
          break
        end
        if match.fridayStartTime > params[:fridayTimes][0].to_i && match.fridayStartTime < params[:fridayTimes][1].to_i
          picked_match = match
          break
        end
      end
      if match.saturdayStartTime != nil && params[:saturdayAvailable] == 'true'
        if match.saturdayStartTime == params[:saturdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.saturdayStartTime < params[:saturdayTimes][0].to_i && match.saturdayEndTime > params[:saturdayTimes][0].to_i
          picked_match = match
          break
        end
        if match.saturdayStartTime > params[:saturdayTimes][0].to_i && match.saturdayStartTime < params[:saturdayTimes][1].to_i
          picked_match = match
          break
        end
      end
      if match.sundayStartTime != nil && params[:sundayAvailable] == 'true'
        if match.sundayStartTime == params[:sundayTimes][0].to_i
          picked_match = match
          break
        end
        if match.sundayStartTime < params[:sundayTimes][0].to_i && match.sundayEndTime > params[:sundayTimes][0].to_i
          picked_match = match
          break
        end
        if match.sundayStartTime > params[:sundayTimes][0].to_i && match.sundayStartTime < params[:sundayTimes][1].to_i
          picked_match = match
          break
        end
      end
    end

    if picked_match == nil
      create_new_match
    else
      # modify existing picked_match
      picked_match.status = 'finished'
      picked_match.user2Id = current_user.id

      # update similar foods
      MatchToFood.where(matchId: picked_match.id).find_each do |food|
        food.destroy unless params[:cuisines].include? food.foodId.to_s
      end

      # update common times
      if picked_match.mondayStartTime != nil && params[:mondayAvailable] == 'true'
        if picked_match.mondayStartTime == params[:mondayTimes][0].to_i
        end
        if picked_match.mondayStartTime < params[:mondayTimes][0].to_i && picked_match.mondayEndTime > params[:mondayTimes][0].to_i
          picked_match.mondayStartTime = params[:mondayTimes][0].to_i
        end
        picked_match.mondayEndTime = params[:mondayTimes][1].to_i if params[:mondayTimes][1].to_i < picked_match.mondayEndTime
      else
        picked_match.mondayStartTime = nil
        picked_match.mondayEndTime = nil
      end
      if picked_match.tuesdayStartTime != nil && params[:tuesdayAvailable] == 'true'
        if picked_match.tuesdayStartTime == params[:tuesdayTimes][0].to_i
        end
        if picked_match.tuesdayStartTime < params[:tuesdayTimes][0].to_i && picked_match.tuesdayEndTime > params[:tuesdayTimes][0].to_i
          picked_match.tuesdayStartTime = params[:tuesdayTimes][0].to_i
        end
        picked_match.tuesdayEndTime = params[:tuesdayTimes][1].to_i if params[:tuesdayTimes][1].to_i < picked_match.tuesdayEndTime
      else
        picked_match.tuesdayStartTime = nil
        picked_match.tuesdayEndTime = nil
      end
      if picked_match.wednesdayStartTime != nil && params[:wednesdayAvailable] == 'true'
        if picked_match.wednesdayStartTime == params[:wednesdayTimes][0].to_i
        end
        if picked_match.wednesdayStartTime < params[:wednesdayTimes][0].to_i && picked_match.wednesdayEndTime > params[:wednesdayTimes][0].to_i
          picked_match.wednesdayStartTime = params[:wednesdayTimes][0].to_i
        end
        picked_match.wednesdayEndTime = params[:wednesdayTimes][1].to_i if params[:wednesdayTimes][1].to_i < picked_match.wednesdayEndTime
      else
        picked_match.wednesdayStartTime = nil
        picked_match.wednesdayEndTime = nil
      end
      if picked_match.thursdayStartTime != nil && params[:thursdayAvailable] == 'true'
        if picked_match.thursdayStartTime == params[:thursdayTimes][0].to_i
        end
        if picked_match.thursdayStartTime < params[:thursdayTimes][0].to_i && picked_match.thursdayEndTime > params[:thursdayTimes][0].to_i
          picked_match.thursdayStartTime = params[:thursdayTimes][0].to_i
        end
        picked_match.thursdayEndTime = params[:thursdayTimes][1].to_i if params[:thursdayTimes][1].to_i < picked_match.thursdayEndTime
      else
        picked_match.thursdayStartTime = nil
        picked_match.thursdayEndTime = nil
      end
      if picked_match.fridayStartTime != nil && params[:fridayAvailable] == 'true'
        if picked_match.fridayStartTime == params[:fridayTimes][0].to_i
        end
        if picked_match.fridayStartTime < params[:fridayTimes][0].to_i && picked_match.fridayEndTime > params[:fridayTimes][0].to_i
          picked_match.fridayStartTime = params[:fridayTimes][0].to_i
        end
        picked_match.fridayEndTime = params[:fridayTimes][1].to_i if params[:fridayTimes][1].to_i < picked_match.fridayEndTime
      else
        picked_match.fridayStartTime = nil
        picked_match.fridayEndTime = nil
      end
      if picked_match.saturdayStartTime != nil && params[:saturdayAvailable] == 'true'
        if picked_match.saturdayStartTime == params[:saturdayTimes][0].to_i
        end
        if picked_match.saturdayStartTime < params[:saturdayTimes][0].to_i && picked_match.saturdayEndTime > params[:saturdayTimes][0].to_i
          picked_match.saturdayStartTime = params[:saturdayTimes][0].to_i
        end
        picked_match.saturdayEndTime = params[:saturdayTimes][1].to_i if params[:saturdayTimes][1].to_i < picked_match.saturdayEndTime
      else
        picked_match.saturdayStartTime = nil
        picked_match.saturdayEndTime = nil
      end
      if picked_match.sundayStartTime != nil && params[:sundayAvailable] == 'true'
        if picked_match.sundayStartTime == params[:sundayTimes][0].to_i
        end
        if picked_match.sundayStartTime < params[:sundayTimes][0].to_i && picked_match.sundayEndTime > params[:sundayTimes][0].to_i
          picked_match.sundayStartTime = params[:sundayTimes][0].to_i
        end
        picked_match.sundayEndTime = params[:sundayTimes][1].to_i if params[:sundayTimes][1].to_i < picked_match.sundayEndTime
      else
        picked_match.sundayStartTime = nil
        picked_match.sundayEndTime = nil
      end

      picked_match.save!

      # send notification emails to users
      NotificationMailer.notification_email(User.find(picked_match.user1Id)).deliver_later
      NotificationMailer.notification_email(User.find(picked_match.user2Id)).deliver_later
    end
  end

  private

    def create_new_match
      # if no existing matches, create new one
      new_match = Match.new
      new_match.user1Id = current_user.id

      if Time.now.wday == 0
        new_match.status = 'next_week'
      else
        new_match.status = 'pending'
      end

      if params[:mondayAvailable] == 'true'
        new_match.mondayStartTime = params[:mondayTimes][0]
        new_match.mondayEndTime = params[:mondayTimes][1]
      end
      if params[:tuesdayAvailable] == 'true'
        new_match.tuesdayStartTime = params[:tuesdayTimes][0]
        new_match.tuesdayEndTime = params[:tuesdayTimes][1]
      end
      if params[:wednesdayAvailable] == 'true'
        new_match.wednesdayStartTime = params[:wednesdayTimes][0]
        new_match.wednesdayEndTime = params[:wednesdayTimes][1]
      end
      if params[:thursdayAvailable] == 'true'
        new_match.thursdayStartTime = params[:thursdayTimes][0]
        new_match.thursdayEndTime = params[:thursdayTimes][1]
      end
      if params[:fridayAvailable] == 'true'
        new_match.fridayStartTime = params[:fridayTimes][0]
        new_match.fridayEndTime = params[:fridayTimes][1]
      end
      if params[:saturdayAvailable] == 'true'
        new_match.saturdayStartTime = params[:saturdayTimes][0]
        new_match.saturdayEndTime = params[:saturdayTimes][1]
      end
      if params[:sundayAvailable] == 'true'
        new_match.sundayStartTime = params[:sundayTimes][0]
        new_match.sundayEndTime = params[:sundayTimes][1]
      end
      new_match.save!

      params[:cuisines].each do |cuisine|
        new_match_to_food = MatchToFood.new(matchId: new_match.id, foodId: cuisine)
        new_match_to_food.save
      end
    end

    def minutesToTime(minutes)
      hours = (minutes / 60).floor + 8
      leftoverMinutes = minutes % 60
      if hours < 12
        output = hours.to_s + ":" + leftoverMinutes.to_s.rjust(2, '0')  + " AM"
      elsif hours == 12
        output = hours.to_s + ":" + leftoverMinutes.to_s.rjust(2, '0') + " PM"
      else
        output = (hours - 12).to_s + ":" + leftoverMinutes.to_s.rjust(2, '0') + " PM";
      end
    end
end