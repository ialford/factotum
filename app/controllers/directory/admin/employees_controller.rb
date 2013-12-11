class Directory::Admin::EmployeesController < Directory::AdminController
 
  def new
    check_current_user_can_add!

    #pull new employees info from ldap
    

    @employee = DirectoryEmployee.new
    

  end


  # GET /directory/admin/employees/1/edit
  def edit
    
    @employee = DirectoryEmployee.find(params[:id])
    check_current_user_can_edit_this!

  end


  # POST /directory/employees
  def create
    
    @employee = DirectoryEmployee.new(params[:directory_employee])
  
    if @employee.save
      flash.now[:success] = 'Employee information was successfully added.'
      redirect_to @employee
    else
      render action: "new"
    end

  end


  # PUT /directory/employees/1
  def update
    @employee = DirectoryEmployee.find(params[:id])

    if @employee.update_attributes(params[:directory_employee])
      flash.now[:success] = 'Employee information was successfully updated.'
      redirect_to @employee
    else
      render action: "edit"
    end
  end



  private
    def check_current_user_can_edit_this!
      if !permission.current_user_can_edit_employee?(@employee)
        flash[:error] = "You are not authorized to edit this employee."
        redirect_to root_path
      end
    end


    def check_current_user_can_add!
      if !permission.current_user_can_add_employee?
        flash[:error] = "You are not authorized to add a new employee."
        redirect_to root_path
      end
    end


end
