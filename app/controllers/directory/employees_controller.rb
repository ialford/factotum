class Directory::EmployeesController < Directory::ApplicationController

  def index

    if params[:include] == "retired"  && permission.current_user_can_see_retired_employees?
      @include_checked = true
      @employees = DirectoryEmployee.unscoped.sorted
    else
      @include_checked = false
      @employees = DirectoryEmployee.sorted
    end

    @permission = permission
    respond_to do |format|
      format.html
      format.json { render json: @employees }
    end
  end


  def show
    @employee = DirectoryEmployee.find(params[:id])


    @permission = permission
    respond_to do |format|
      format.html
      format.json { render json: @employee }
    end
  end

end