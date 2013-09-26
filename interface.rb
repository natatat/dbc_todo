require 'csv'

require_relative 'todo'

class TodoInterface

  def initialize
    @command = ARGV[0]
    @task_id = ARGV[1..-1]
    @todo_list = Todo.new('todo.csv')
  end

  def run!
    case @command
      when "add"
        @todo_list.add(@task_id)
      when "list"
        @todo_list.list
      when "delete"
        @todo_list.delete(@task_id)
      when "complete"
        @todo_list.complete(@task_id)
      # when "save"
      #   @todo_list.save
      else
        puts "Please input list, delete, complete, save"
        @command = gets.chomp
        run!
    end  
  end

end


TodoInterface.new.run!
