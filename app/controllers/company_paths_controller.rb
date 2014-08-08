class CompanyPathsController
  def menu_options
    puts "=========="
    puts "Companies"
    puts "=========="
    puts "(a)dd a company\n(v)iew company list"
    command = clean_gets
    company_paths_menu_navigation(command)
  end

  def company_paths_menu_navigation(command)
    case command
    when "a"
      puts "Please enter a company name:"
      add
    when "v"
    else
      puts "'#{command}' is not a valid option."
    end
  end

  def add
    name = clean_gets
    company = Company.create(name: name)
    if company.new_record?
      puts company.errors.full_messages
    else
      puts "#{company} has been added to your list of companies!"
    end
  end


end
