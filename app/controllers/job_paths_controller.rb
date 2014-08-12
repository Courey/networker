class JobPathsController
  def menu_options
    puts "=========="
    puts "   Jobs"
    puts "=========="
    puts "(a)dd a job\n(v)iew jobs list"
    command = clean_gets
    job_paths_menu_navigation(command)
  end

  def job_paths_menu_navigation(command)
    case command
    when "a"
      add
    when "v"
      list
    else
      puts "'#{command}' is not a valid option."
    end
  end

  def add
    puts "Please enter job title:"
    title = clean_gets
    job = Job.create(name: title)
    if job.new_record?
      puts job.errors.full_messages
    else
      puts "#{job.name} has been added to your job list!"
    end
  end

  def list
    puts "============"
    puts "  Job List"
    puts "============"

    jobs.each_with_index do |job, index|
      puts "#{index + 1}. #{job.name}"
    end
    Router.navigate_jobs(self)
  end

  def view(job_number)
    job = jobs[job_number - 1]
    if job
      puts "==========\n#{job.name}\n=========="
      if job.company_id
        company = Company.find_by(id: job.company_id)
        puts company.name
      else
        puts "Type 'c' to add a company."
      end
      if job.description
        puts job.description
      else
        puts "Type 'd' to add description."
      end
      if job.requirements
        puts "Requirements: #{job.requirements}"
      else
        puts "Type 'r' to add requirements."
      end
      job_options(job)
    else
      puts "Sorry, job #{job_number} doesn't exist."
    end
  end

  def job_options(job)
    command = clean_gets
    case command
    when "d"
      add_description(job)
    when "r"
      add_requirements(job)
    when "c"
      add_company(job)
    else
      puts "#{command} is not a valid option."
    end
  end

  def add_description(job)
    puts "enter your description:"
    description = clean_gets
    job.update!(description: description)
    puts "#{job.description}"
  end

  def add_requirements(job)
    puts "enter contact title:"
    requirements = clean_gets
    job.update!(requirements: requirements)
    puts "#{job.requirements}"
  end

  def add_company(job)
    puts "Please enter company list number to add a company to this job."
    companies.each_with_index do |company, index|
      puts "#{index + 1}. #{company.name}"
    end
    company_index = clean_gets.to_i
    company = companies[company_index - 1]
    job.update!(company_id: company.id)
    puts "#{company.name} has been added to #{job.name}."
  end

  private

  def jobs
    @jobs ||= Job.all
  end

  def companies
    @companies ||= Company.all
  end

end
