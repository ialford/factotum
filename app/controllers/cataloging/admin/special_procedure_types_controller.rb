class Cataloging::Admin::SpecialProcedureTypesController < Cataloging::AdminController
  before_filter :login_user!

  layout "generic_modal"

  def new
    @special_procedure_type = Cataloging::SpecialProcedureType.new
  end

  def create
    @special_procedure_type = Cataloging::SpecialProcedureType.new(special_params)

    if @special_procedure_type.save
      flash.now[:success] = "Your new procedure has been added."
      render partial: "special_procedure_type", locals: {special_procedure_types: Cataloging::SpecialProcedureType.sorted}
    else
      flash.now[:error] = @special_procedure_type.errors.full_messages.to_sentence
      render 'new', status: 403
    end
  end

  def edit
     @special_procedure_type = Cataloging::SpecialProcedureType.find(params[:id])
  end


  def update
      @special_procedure_type = Cataloging::SpecialProcedureType.find(params[:id])

    if @special_procedure_type.update_attributes(special_params)
      flash.now[:success] = "Your procedure has been updated."
      render partial: "special_procedure_type", locals: {special_procedure_types: Cataloging::SpecialProcedureType.sorted}
    else
      flash.now[:error] = @special_procedure_type.errors.full_messages.to_sentence
      render 'edit', status: 403
    end
  end

  def destroy
    @special_procedure_type = Cataloging::SpecialProcedureType.find(params[:id])

    begin
      @special_procedure_type.destroy
      flash[:success] = "Your delete has been successful."
    rescue ActiveRecord::DeleteRestrictionError => e
      Raven.capture_exception(e)
      @special_procedure_type.errors.add(:base, e)
      flash[:error] = "#{e}"
    ensure
      redirect_to cataloging_admin_path
    end
  end


  def show

  end

private
  def special_params
    params.require(:cataloging_special_procedure_type).permit!
  end

end
