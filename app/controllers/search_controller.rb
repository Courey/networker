class SearchController
  def menu_options
    puts "=========="
    puts "  Search"
    puts "=========="
    puts "1. Search for jobs by company."
    puts "2. Search for contacts by company."
    puts "3. Search for jobs by job title."
    puts "4. Search for jobs at companies where you have contacts."
    command = clean_gets
    search_navigation(command)
  end

  def search_navigation(command)
    case command
    when "1"
      search_by_company
    when "2"
      search_contacts_by_company
    when "3"
      search_by_job
    when "4"
      search_by_company_with_contact
    else
      puts "#{command} is not a valid option."
    end
  end

  def search_by_company
    puts "Select a company index to search for jobs."
    companies.each_with_index do |company, index|
      puts "#{index + 1}. #{company.name}"
    end
    company_index = clean_gets.to_i
    company = companies[company_index - 1]
    if company
      puts "======================"
      puts "Job Search by Company"
      puts "======================"
      job_list = Job.where(company_id: company.id)
      job_list.each_with_index do |job, index|
        puts "#{index + 1}. #{job.name}"
      end
      puts "To view job details enter index number."
      command = clean_gets.to_i
      job = job_list[command - 1]
      view_job(job)
    else
      puts "#{company_index} is not a valid option."
    end
  end

  def view_job(job)
    puts "Title: #{job.name}"
    job_company = Company.find_by(id: job.company_id)
    puts "Company: #{job_company.name}"
    puts "Description: #{job.description}"
    puts "Requirements: #{job.requirements}"
    contact_list = Contact.where(company_id: job.company_id)
    if contact_list
      contact_list.each do |contact|
        puts "Contact: #{contact.first_name} #{contact.last_name}"
        puts "Phone: #{contact.phone}"
        puts "Email: #{contact.email}"
      end
    end
  end

  def search_contacts_by_company
    puts "Select a company index number to find all contacts at that company."
    companies.each_with_index do |company, index|
      puts "#{index + 1}. #{company.name}"
    end
    company_index = clean_gets.to_i
    company = companies[company_index - 1]
    contact_list = Contact.where(company_id: company.id)
    puts "=========================="
    puts "Contact Search by Company"
    puts "=========================="
    if contact_list
      contact_list.each_with_index do |contact, index|
        puts "#{index + 1}. #{contact.first_name} #{contact.last_name}"
      end
      puts "To view contact details enter index number."
      command = clean_gets.to_i
      contact = contact_list[command - 1]
      view_contact(contact)
    else
      puts "You have no contacts at this company."
    end
  end

  def view_contact(contact)
    puts "#{contact.first_name} #{contact.last_name}"
    contact_company = Company.find_by(id: contact.company_id)
    puts "Company: #{contact_company.name}"
    puts "Title: #{contact.title}"
    puts "Description: #{contact.description}"
    puts "Phone: #{contact.phone}"
    puts "Email: #{contact.email}"
    menu_loop_or_exit
  end

  def search_by_job
    puts "Enter a job title to search by position."
    job_title = clean_gets
    unless job_title == ""
      job_list = Job.where(name: job_title)
      puts "=========================="
      puts "Job Search by Job Title"
      puts "=========================="
      if job_list
        job_list.each_with_index do |job, index|
          puts "#{index + 1}. #{job.name}"
        end
        puts "To view job details enter index number."
        command = clean_gets.to_i
        job = job_list[command - 1]
        view_job(job)
      end
    else
      puts "You must enter a job title to search."
    end
  end

  def view_job(job)
    puts "Title: #{job.name}"
    job_company = Company.find_by(id: job.company_id)
    puts "Company: #{job_company.name}"
    puts "Description: #{job.description}"
    puts "Requirements: #{job.requirements}"
    menu_loop_or_exit
  end

  def search_by_company_with_contact
    limit = "0"
    puts "=========================="
    puts "Companies with Contacts"
    puts "=========================="
    contacts_list = Contact.where("company_id >= ?", limit)
    contacts_list.each do |contact|
      company = Company.find(contact.company_id)
      puts "#{contact.first_name} #{contact.last_name}"
      puts "Company: #{company.name}"
      puts ""
    end
    menu_loop_or_exit
  end

  def menu_loop_or_exit
    puts "Type 'q' to quit."
    puts "Type 'm' to return to the main menu."
    command = clean_gets
    case command
    when "m"
      Router.main_menu
    when "q"
    else
      puts "#{command} is not a valid option."
    end
  end

  private

  def contacts
    @contacts ||= Contact.all
  end

  def jobs
    @jobs ||= Job.all
  end

  def companies
    @companies ||= Company.all
  end

end
