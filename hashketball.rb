require "pry"

def lookupPlayer(name)
  if game_hash[:home][:players][name] != nil
    return game_hash[:home][:players][name]
  else
    return game_hash[:away][:players][name]
  end
end

def most_thing_player
  most_player = "no one"
  most_player_name = "no one"
  most_thing = 0
  game_hash.each_key do |location|
    game_hash[location][:players].each_key do |player|
      current_player = game_hash[location][:players][player]
      if current_player[yield[0]] > most_thing
        most_player = current_player
        most_player_name = player
        most_thing = current_player[yield[0]]
      end
    end
  end
  return [most_player,most_player_name]
end

def big_shoe_rebounds
  return most_thing_player{:shoe}   [0][:rebounds]
end

def most_points_scored
  return most_thing_player{:points}   [1]
end

def player_with_longest_name
  longest_player_name = ""
  game_hash.each_key do |location|
    game_hash[location][:players].each_key do |player|
      if player.length > longest_player_name.length
        longest_player_name = player
      end
    end
  end
  return longest_player_name
end

def long_name_steals_a_ton?
  longName = player_with_longest_name
  bestStealer = most_thing_player{[:steals]}[1]
  return bestStealer == longName
end

def winning_team
  homepoints = 0 
  awaypoints = 0 
  game_hash[:home][:players].each_key do |player|
    homepoints += lookupPlayer(player)[:points]
  end
  game_hash[:away][:players].each_key do |player|
    awaypoints += lookupPlayer(player)[:points]
  end
  if homepoints > awaypoints
    return game_hash[:home][:team_name]
  else
    return game_hash[:away][:team_name]
  end
end


def num_points_scored(name)
  return lookupPlayer(name)[:points]
end

def shoe_size(name)
  return lookupPlayer(name)[:shoe]
end

def team_colors(teamname)
  game_hash.each_key do |team|
    if game_hash[team][:team_name] == teamname
      return game_hash[team][:colors]
    end
  end
end

def team_names
  return [game_hash[:home][:team_name],game_hash[:away][:team_name]]
end

def player_numbers(teamname)
  array = []
  game_hash.each_key do |team|
    if game_hash[team][:team_name] == teamname
      game_hash[team][:players].each_key do |player|
        array.push(game_hash[team][:players][player][:number])
      end
    end
  end
  return array
end

def player_stats(name)
  return lookupPlayer(name)
end

def good_practices
  game_hash.each do |location, team_data|
    #are you ABSOLUTELY SURE what 'location' and 'team data' are? use binding.pry to find out!
    binding.pry
    team_data.each do |attribute, data|
      #are you ABSOLUTELY SURE what 'attribute' and 'team data' are? use binding.pry to find out!
      binding.pry
 
      #what is 'data' at each loop throughout .each block? when will the following line of code work and when will it break?
      data.each do |data_item|
          binding.pry
      end
    end
  end
end

def game_hash
  hash = {}
  hash[:home] = hometeam
  hash[:away] = awayteam
  return hash
end

def hometeam
  team = {}
  team[:colors] = ['Black','White']
  team[:team_name] = "Brooklyn Nets"
  team[:players] = {}
  team[:players]["Alan Anderson"] = makePlayer(0,16,22,12,12,3,1,1)
  team[:players]["Reggie Evans"] = makePlayer(30,14,12,12,12,12,12,7)
  team[:players]["Brook Lopez"] = makePlayer(11,17,17,19,10,3,1,15)
  team[:players]["Mason Plumlee"] = makePlayer(1,19,26,11,6,3,8,5)
  team[:players]["Jason Terry"] = makePlayer(31,15,19,2,2,4,11,1)
  return team
end

def awayteam
  team = {}
  team[:colors] = ['Turquoise','Purple']
  team[:team_name] = "Charlotte Hornets"
  team[:players] = {}
  team[:players]["Jeff Adrien"] = makePlayer(4,18,10,1,1,2,7,2)
  team[:players]["Bismack Biyombo"] = makePlayer(0,16,12,4,7,22,15,10)
  team[:players]["DeSagna Diop"] = makePlayer(2,14,24,12,12,4,5,5)
  team[:players]["Ben Gordon"] = makePlayer(8,15,33,3,2,1,1,0)
  team[:players]["Kemba Walker"] = makePlayer(33,15,6,12,12,7,5,12)
  return team
end

def makePlayer(number,shoe,points,rebounds,assists,steals,blocks,slamdunks)
    player = {:number => number,:shoe => shoe,:points => points,:rebounds => rebounds,:assists => assists,:steals => steals,:blocks => blocks,:slam_dunks => slamdunks}
end