class Dungeon
	attr_accessor :player, :weapon
	
	def initialize(player_name)
		@player = Player.new(player_name)
		@rooms = []
		@weapons = []
	end
	
	def add_room(reference, name, description, connections)
		@rooms << Room.new(reference, name, description, connections)
	end
	
	def start(location)
		@player.location = location
		show_current_description
	end
	
	def start_weapon(weapon)
		@player.weapon = weapon
		show_current_weapon
	end
	
	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
	end
	
	def find_room_in_dungeon(reference)
		@rooms.detect { |room| room.reference == reference }
	end
	
	def find_room_in_direction(direction)
		find_room_in_dungeon(@player.location).connections[direction]
	end
	
	def go(direction)
		puts "You go " + direction.to_s
		@player.location = find_room_in_direction(direction)
		show_current_description
	end
	
	def add_weapon(referencew, namew, descriptionw)
		@weapons << Weapon.new(referencew, namew, descriptionw)
	end
	
	def find_weapon_in_dungeon(referencew)
		@weapons.detect { |weapon| weapon.referencew == referencew }
	end
	
	def show_current_weapon
		find_weapon_in_dungeon(@player.weapon).weapon_description
	end
	
	class Player
		attr_accessor :name, :location, :weapon
		
		def initialize(name)
			@name = name
		end
	end
	
	class Room 
		attr_accessor :reference, :name, :description, :connections
		
		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end
		
		def full_description
			@name + "\n\nYou are in " + @description
		end
	end
	
	class Weapon
		attr_accessor :referencew, :namew, :descriptionw
			
		def initialize(referencew, namew, descriptionw)
			@referencew = referencew
			@namew = namew
			@descriptionw = descriptionw
		end
				
		def weapon_description
			"You have a " + @namew + " with " + @descriptionw
		end
	end
end

my_dungeon = Dungeon.new("Matty")
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave, :south => :cavepond})
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {:east => :largecave})
my_dungeon.add_room(:cavepond, "Cave Pond", "a cave pond", {:south => :smallcave})
my_dungeon.add_weapon(:sword, "Basic Sword", "1 Strength")
my_dungeon.add_weapon(:bow, "Bow and Arrow", "4 Strenght")

my_dungeon.start_weapon(:sword)
my_dungeon.start(:smallcave)
my_dungeon.go(:east)

my_dungeon.show_current_weapon
