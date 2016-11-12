class MatchesController < ApplicationController
  before_action :authenticate_user!

  def make_match
    @day_of_week = Time.now.wday # sunday = 0, monday = 1, ...
  end

  def match_found
  end

  def match_not_found
  end

  def match_request
    # if no existing matches, create new one
    new_match = Match.new
    new_match.user1Id = current_user.id
    new_match.status = 'pending'
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
end
