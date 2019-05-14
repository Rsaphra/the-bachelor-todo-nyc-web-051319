require 'pry'

##returns the name of a contestant hash
def get_name(contestant)
  contestant["name"]
end

##returns first instance of a contestant that has 'attribute'
def contestant_attribute_by_season(season, attribute)
  season.find do |current_contestant|
    #binding.pry
    current_contestant.has_value?(attribute)
  end
end

##returns list of all contestants who have 'attribute' in a season
def collect_contestants_by_attribute(season, attribute)
  full_list = season.select do |current_contestant|
    current_contestant.has_value?(attribute)
  end
  binding.pry
  full_list
end

##returns an incrememted counter for all players in a season who have
##atribute
def get_count_by_attribute(season, attribute, counter)
  season.each do |contestant|
    if contestant.has_value?(attribute)
      counter += 1
    end
  end
  counter
end

##iterates through each season and returns the first instance of
##a contestant having 'attribute'
def get_contestant_attribute(data, attribute)
  data.each do |season|
    found_contestant = contestant_attribute_by_season(season[1], attribute)
    if found_contestant != nil
      #binding.pry
        return found_contestant
      end
    #binding.pry
  end
end

##return the season hash that matches the 'season ' name
def get_season(data, season)
  data.find do |current_season|
    #binding.pry
    current_number = current_season[0]
    current_number == season
  end
end

##Searches a season to find the first player who has attribute
def match_contestant_attribute(season, attribute)
  season.find do |contestant|
    #binding.pry
    contestant.has_value?(attribute)
  end
end

##return just the first name of contestant
def format_contestant_name(contestant_data)
  name = contestant_data["name"]
  split_name = name.split(" ")
  split_name[0]
end

##find the contestant who won 'season' and return just the first name
def get_first_name_of_season_winner(data, season)
  found_season = get_season(data, season)
  #binding.pry
  winning_contestant = match_contestant_attribute(found_season[1], "Winner")
  format_contestant_name(winning_contestant)
end

##get a list of contestants who all share 'attribute'
def get_attribute_counter(data, attribute)
  counter = 0
  data.each do |season|
    counter = get_count_by_attribute(season[1], attribute, counter)
    #binding.pry
  end
  #binding.pry
  counter
end

def calculate_avg(sum, total)
  total_float = total.to_f
  avg = sum/total_float
  rounded_avg = avg.round
  rounded_avg
end

###passed season, returns the cumulative average of all the attributes
def get_avg_attribute(season, attribute)
  sum = 0
  total = 0
  season[1].each do |contestant|
    #binding.pry
    sum += contestant[attribute].to_i
    #binding.pry
    total += 1
  end
  calculate_avg(sum, total)
end

#########

def get_contestant_name(data, occupation)
  matched_contestant = get_contestant_attribute(data, occupation)
  get_name(matched_contestant)
end

def count_contestants_by_hometown(data, hometown)
  get_attribute_counter(data, hometown)
end

def get_occupation(data, hometown)
  matched_contestant = get_contestant_attribute(data, hometown)
  matched_contestant["occupation"]
end

def get_average_age_for_season(data, season)
  found_season = get_season(data, season)
  get_avg_attribute(found_season, "age")
end
