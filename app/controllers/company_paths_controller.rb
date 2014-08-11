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
      list
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
      puts "#{company.name} has been added to your list of companies!"
    end
  end

  def list
    puts "============"
    puts "Company List"
    puts "============"

    companies.each_with_index do |company, index|
      puts "#{index + 1}. #{company.name}"
    end
    Router.navigate_companies(self)
  end

  def view(company_number)
    company = companies[company_number - 1]
    if company
      puts "==========\n#{company.name}\n=========="
      if company.description
        puts "#{company.description}"
      else
        puts "Type 'a' to add description."
        add_description(company)
      end
    else
      puts "Sorry, company #{company_number} doesn't exist."
    end
  end

  def add_description(company)
    command = clean_gets
    case command
    when "a"
      puts "enter your description:"
      description = clean_gets
      company.update(description: description)
      puts company.description
    else
      puts "#{command} is not a valid command."
    end
  end

  private

  def companies
    @companies ||= Company.all
  end

end
