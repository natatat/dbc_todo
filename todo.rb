# What classes do you need?

# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).x

class TodoModel

  def initialize(file_name)
    @file_name = file_name
    @todo_items = []
    # parse
  end

  def create_new_list
    @file_name = File.new(@file_name, "w+")
  end

  def parse
    File.open(@file_name, 'r').readlines.each do |row|
      @todo_items << row
    end
  end

  def add(description)
    @todo_items << "#{@todo_items.length + 1} [ ] #{description.join(" ")}\n"
    save
  end

  def delete(item_id)
    @todo_items.delete_at(item_id.join.to_i-1)
    # Re-numbers the list after deleted item fucks it up.
    @togdo_items.each_with_index do |item,index|
      unless item.start_with?((index+1).to_s)
        item.gsub!(/^\d*/, (index+1).to_s)
      end
    end
    save
  end

  def complete(item_id)
    @todo_items[item_id.join.to_i-1].gsub!(/\[.*\]/, "[X]")
    save
  end

  def uncomplete(item_id)
    @todo_items[item_id.join.to_i-1].gsub!(/\[.*\]/, "[ ]")
    save
  end

  def list
    @todo_items.each do |element|
      puts element
    end
  end

  def save
    File.open(@file_name, "w") do |file|
      @todo_items.each do |row|
        file << row
      end
    end
  end

end
