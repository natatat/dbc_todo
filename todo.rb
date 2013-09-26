# What classes do you need?

# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).

require 'csv'

class Todo

  def initialize(file_name)
    @file_name = file_name
    @todo_items = []
    parse
  end

  def parse
    CSV.foreach(@file_name) do |row|
      @todo_items << row
    end
  end

  def add(todo_item)
    todo_item_condensed = []
    todo_item_condensed << todo_item.join(" ")
    @todo_items << todo_item_condensed
    save
  end

  def list
    @todo_items.each_with_index do |element, index|
      puts "#{index+1}: #{element.join(" ")}"
    end
  end

  def delete(item_id)
    @todo_items.delete_at(item_id.join.to_i-1)
    save
  end

  def complete(item_id)
    @todo_items[item_id.join.to_i-1][0] += " (COMPLETE!)"
    # @completed_task = @todo_items[item_id.join.to_i-1][0] + "(COMPLETE!)"

    save
  end

  def save
    CSV.open(@file_name, "w") do |csv|
      @todo_items.each do |row|
        csv << row
      end
    end
  end

end
