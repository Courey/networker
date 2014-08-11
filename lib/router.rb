class Router

  def self.main_menu
    puts "1. Companies\n 2. Contacts\n 3. Jobs"
  end

  def self.routing
    command = clean_gets
    case command
    when "1"
      company_paths_controller = CompanyPathsController.new()
      company_paths_controller.menu_options
    when "2"
      contact_paths_controller = ContactPathsController.new()
      contact_paths_controller.menu_options
    else
      puts "'#{command}' is not a valid option."
    end
  end

  def self.navigate_companies(company_paths_controller)
    puts "To view company enter list number. To add a company type 'add'."
    command = clean_gets
    case command
    when "add"
      company_paths_controller.add
    when /\d+/
      company_paths_controller.view(command.to_i)
    else
      puts "I don't know the '#{command}' command."
    end
  end

  def self.navigate_contacts(contact_paths_controller)
    puts "To view a contact enter list number. To add a contact type 'add'."
    command = clean_gets
    case command
    when "add"
      contact_paths_controller.add
    when /\d+/
      contact_paths_controller.view(command.to_i)
    else
      puts "I don't know the '#{command}' command."
    end
  end
#   def self.navigate_skills_menu(skills_controller)
#     command = clean_gets
#     case command
#     when "add"
#       skills_controller.add
#     when /\d+/
#       skills_controller.view(command.to_i)
#     else
#       puts "I don't know the '#{command}' command."
#     end
#   end
#
#   def self.navigate_training_paths_menu(training_paths_controller)
#     command = clean_gets
#
#     case command
#     when "add"
#       training_paths_controller.add
#     when /\d+/
#       training_paths_controller.view(command.to_i)
#     else
#       puts "I don't know the '#{command}' command."
#     end
#   end
end
