class Users::ContactsController < ApplicationController

	def index
	  @opinion = Opinion.new
    @contact = Contact.all
    @user = current_user
  end

	def show
    @contact = Contact.find(params[:id])
  end

	private
	def contact_params
		params.require(:contact).permit(:contact_title, :contact_body)
	end

end
