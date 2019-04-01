class OrganizationView

  def initialize

  end
  

  def employee_unit_all_titles(organizational_unit_id, employee_id)
  	DirectoryEmployeeUnit.all_titles_for_employee(employee_id, organizational_unit_id)
  end


  def show_division_collapse_div(level)
  	true if level == 1
  end

  def show_program_collapse_div(level)
  	true if level == 2
  end


  def chair_head_display(unit_type)
    if unit_type == 'Departments'
      return "Head"
    elsif unit_type == 'Library Teams'
      return "Chair"
    else
      return "Representative"
    end
  end


end



