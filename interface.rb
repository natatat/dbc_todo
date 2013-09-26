require 'csv'

require_relative 'todo'

class TodoController

  def initialize(arguments)
    @command = arguments[:command]
    @task_id = arguments[:task_id]
    @todo_list = arguments[:new_list]
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
      else
        puts "Please input list, delete, complete, save"
        @command = gets.chomp
        run!
    end  
  end

end

TodoController.new(:command => ARGV[0], :task_id => ARGV[1..-1], :new_list => TodoModel.new('todo.csv')).run!
