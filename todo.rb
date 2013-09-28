require 'csv'

# maybe read/write as a csv file, then output as a txt file

class TodoViewer

  def self.render(string)
    puts string
  end

  def self.show_list(list)
    list.each do |task|
      puts "#{task.id} #{task.complete?} #{task.description}"
    end
  end

end

class FileManager

  def self.create_new_txt_file(file_name)
    @txt_file = File.new(file_name,'w+')
  end

  def self.parse(file_name)
    @tasks_list = []
    @parsed_tasks = File.open(file_name,'r').readlines
    @parsed_tasks.each_with_index do |desc, idx|
      @tasks_list << Task.new(:description => desc, :id => (idx+1))
    end
  end

  def self.save(file_name)
    File.open(file_name,'w') do |file|
      @tasks_list.each do |task|
        file << task.description
      end
    end
  end

  def output_txt_file

  end

  def self.tasks_list
    @tasks_list
  end

end

class List
  attr_accessor :tasks_list

  def initialize(args)
    @file_name = args[:file_name]
    @tasks_list = args[:tasks_list]
    @time_created = Time.now
    # @title = nil
  end

  def add(task)
    @tasks_list << task

    FileManager.save(@file_name)
  end

  def delete(task_number)
    @tasks_list.delete_at(task_number-1)

    # renumbers the list
    index = task_number-1
    until index == @tasks_list.length
      @tasks_list[index].id -= 1
      index += 1
    end

    FileManager.save(@file_name)
  end

end

class Task
  attr_accessor :completed, :id
  attr_reader :description

  def initialize(args)
    @description = args[:description]
    @id = args[:id]
    @completed = args[:completed] || false
  end

  def complete
    @completed = true
    # save as objects to csv file
  end

  def uncomplete
    @completed = false
    # save as objects to csv file
  end

  def complete?
    if @completed == true
      "[X]"
    else
      "[ ]"
    end
  end

end

###################################

class TodoApp

  def initialize(arguments)
    @command = arguments[:command]
    @task_desc = arguments[:task_desc]
    @file_name = arguments[:file_name]
  end

  def run!
    if @file_name.end_with?(".txt")
      if File.exists?(@file_name)
        FileManager.parse(@file_name)
      else
        FileManager.create_new_txt_file(@file_name)
        FileManager.parse(@file_name)
      end
      list = List.new(:file_name => @file_name, :tasks_list => FileManager.tasks_list)
      # everytime this is run, the list is created with new task objects from the text file, so completeness is overruled by falseness.

    else
      TodoViewer.render("Please specify a .txt file")
    end

    case @command
      when "add"
        list.add(Task.new(:description => @task_desc, :id => list.tasks_list.length))
      when "list"
        TodoViewer.show_list(list.tasks_list)
      when "delete"
        list.delete(@task_desc[0].to_i)
      when "done"
        task = list.tasks_list[@task_desc[0].to_i-1]
        task.complete
      when "jk"
        task = list.tasks_list[@task_desc[0].to_i-1]
        task.uncomplete
      else
        exit
      end
  end

end

TodoApp.new(:file_name => ARGV[0], :command => ARGV[1], :task_desc => ARGV[2..-1]).run!

###################################

# FileManager.parse("natalie.txt")
# FileManager.tasks_list
# list = List.new(FileManager.tasks_list)
# list.add(Task.new(:description => "a task or something", :id => list.tasks_list.length+1))
# TodoViewer.show_list(list.tasks_list) # calling list
# puts
# list.delete(3)
# TodoViewer.show_list(list.tasks_list) # calling list
# puts

# task = list.tasks_list[2-1]
# task.completed = true

# TodoViewer.show_list(list.tasks_list)
# task = list.tasks_list[2-1]
# task.completed = false
# puts
# TodoViewer.show_list(list.tasks_list)

###################################

__END__

class TodoModel
  # def initialize(file_name)
  #   @file_name = file_name
  #   @todo_items = []
  #   # parse
  # end

  # def create_new_list
  #   @file_name = File.new(@file_name, "w+")
  # end

  # def parse
  #   File.open(@file_name, 'r').readlines.each do |row|
  #     @todo_items << row
  #   end
  # end

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

  # def complete(item_id)
  #   @todo_items[item_id.join.to_i-1].gsub!(/\[.*\]/, "[X]")
  #   save
  # end

  # def uncomplete(item_id)
  #   @todo_items[item_id.join.to_i-1].gsub!(/\[.*\]/, "[ ]")
  #   save
  # end

  # def list
  #   @todo_items.each do |element|
  #     puts element
  #   end
  # end

  # def save
  #   File.open(@file_name, "w") do |file|
  #     @todo_items.each do |row|
  #       file << row
  #     end
  #   end
  # end

end
