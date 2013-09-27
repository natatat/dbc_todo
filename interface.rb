require_relative 'todo'

class TodoController

  def initialize(arguments)
    @command = arguments[:command]
    @task_id = arguments[:task_id]
    @todo_list = arguments[:todo_list]
    @file = ARGV[0]
  end

  def run!
    if @file.end_with?(".txt")
      if File.exists?(@file)
        @todo_list.parse
      else
        @todo_list.create_new_list
        @todo_list.parse
      end
    else
      puts "Please specify a .txt file"
    end

    case @command
      when "add"
        @todo_list.add(@task_id)
      when "list"
        @todo_list.list
      when "delete"
        @todo_list.delete(@task_id)
      when "complete"
        @todo_list.complete(@task_id)
      when "jk"
        @todo_list.uncomplete(@task_id)
      else
        exit
      end

  end

end

TodoController.new(:command => ARGV[1], :task_id => ARGV[2..-1], :todo_list => TodoModel.new(ARGV[0])).run!
