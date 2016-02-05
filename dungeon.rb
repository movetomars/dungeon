class Dungeon
    attr_accessor :player

    def initialize(player_name)
        @player = Player.new(player_name)
        @rooms = []
    end

    def add_room(reference, name, description, connections)
        @rooms << Room.new(reference, name, description, connections)
    end
    
    def start(location)
        @player.location = location
        show_current_description
    end
    
    def show_current_description
        puts find_room_in_dungeon(@player.location).full_description
    end
    
    def find_room_in_dungeon(reference)
        @rooms.detect {|room| room.reference = reference}
    end
    
    def find_room_in_dungeon(direction)
        find_room_in_dungeon(@player.location).connections[direction]
    end
    
    def go(direction)
        puts "You go " + direction.to_s
        @player.location = find_room_in_dungeon.direction
        show_current_description
    end
    
    
    class Player
        attr_accessor :name, :location
        
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
    
end

my_dungeon = Dungeon.new("Maia the Mage")

my_dungeon.add_room(:tallesttower, "The Tallest Tower", "a small, circular room with high ceilings of flagstone. Around you you see many chests. There is one tiny window. If you try, you might be able to squeeze through.", {:south => :coolair})
my_dungeon.add_room(:coolair, "Free-falling in cool air", "the middle of a chill autumn night, descending quickly. As you fall, you have just enough time to think that you might be falling farther than you anticipated.", {:north => :tallesttower})

my_dungeon.start(:tallesttower)