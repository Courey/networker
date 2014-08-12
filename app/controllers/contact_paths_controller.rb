class ContactPathsController
  def menu_options
    puts "=========="
    puts "Contacts"
    puts "=========="
    puts "(a)dd a contact\n(v)iew contacts list"
    command = clean_gets
    contact_paths_menu_navigation(command)
  end

  def contact_paths_menu_navigation(command)
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
    puts "Please enter contact's first name:"
    first_name = clean_gets
    puts "Enter contact's last name:"
    last_name = clean_gets
    contact = Contact.create(first_name: first_name, last_name: last_name)
    if contact.new_record?
      puts contact.errors.full_messages
    else
      puts "#{contact.first_name} #{contact.last_name} has been added to your list of contacts!"
    end
  end

  def list
    puts "============"
    puts "Contact List"
    puts "============"

    contacts.each_with_index do |contact, index|
      puts "#{index + 1}. #{contact.first_name} #{contact.last_name}"
    end
    Router.navigate_contacts(self)
  end

  def view(contact_number)
    contact = contacts[contact_number - 1]
    if contact
      puts "==========\n#{contact.first_name} #{contact.last_name}\n=========="
      if contact.description
        puts contact.description
      else
        puts "Type 'd' to add description."
      end
      if contact.title
        puts "Title: #{contact.title}"
      else
        puts "Type 't' to add a title."
      end
      if contact.email
        puts "Email: #{contact.email}"
      else
        puts "Type 'e' to add an email."
      end
      if contact.phone
        puts "Phone: #{contact.phone}"
      else
        puts "Type 'p' to add a phone number."
      end
      if contact.company_id
        company = Company.find_by(id: contact.company)
        puts company.name
      else
        puts "Type 'c' to add a company."
      end
      contact_options(contact)
    else
      puts "Sorry, contact #{contact_number} doesn't exist."
    end
  end

  def contact_options(contact)

    command = clean_gets
    case command
    when "d"
      add_description(contact)
    when "t"
      add_title(contact)
    when "e"
      add_email(contact)
    when "p"
      add_phone(contact)
    when "c"
      add_company(contact)
    else
      puts "#{command} is not a valid option."
    end
  end

  def add_description(contact)
    puts "enter your description:"
    description = clean_gets
    contact.update!(description: description)
    puts "#{contact.description}"
  end

  def add_title(contact)
    puts "enter contact title:"
    title = clean_gets
    contact.update!(title: title)
    puts "#{contact.title}"
  end

  def add_email(contact)
    puts "enter contact's email:"
    email = clean_gets
    contact.update!(email: email)
    puts "#{contact.email}"
  end

  def add_phone(contact)
    puts "enter contact's phone number:"
    number = clean_gets
    contact.update!(phone: number)
    puts "#{contact.phone}"
  end

  def add_company(contact)
    puts "Please enter company list number to add a company to this contact."
    companies.each_with_index do |company, index|
      puts "#{index + 1}. #{company.name}"
    end
    company_index = clean_gets.to_i
    company = companies[company_index - 1]
    contact.update!(company_id: company.id)
    puts "#{company.name} has been added to #{contact.name}."
  end

  private

  def contacts
    @contacts ||= Contact.all
  end

  def companies
    @companies ||= Company.all
  end

end
