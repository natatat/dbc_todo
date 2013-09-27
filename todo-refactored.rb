require_relative 'todo'


class TodoViewer
  def show_list(todo_list)
    todo_list.todo_items.each do |element|
      puts element
    end
  end
end


class TodoController
  attr_reader :todo_viewer

  def initialize(arguments)
    @command = arguments[:command]
    @task_id = arguments[:task_id]
    @todo_list = arguments[:todo_list]
    @todo_viewer = arguments[:todo_viewer]
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
        show_list(@todo_list)
        # @todo_list.list
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

  def show_list(arg)
    @todo_viewer.show_list(@todo_list)
  end

end

TodoController.new(:command => ARGV[1], :task_id => ARGV[2..-1], :todo_list => TodoModel.new(ARGV[0]), :todo_viewer => TodoViewer.new).run!

