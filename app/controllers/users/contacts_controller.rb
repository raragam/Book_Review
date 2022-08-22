class Users::ContactsController < ApplicationController

  def new
		@contact = Contact.new
	end

	 def index
    @contact = Contact.all
    #@user = current_user
  end

	def create
		@contact = Contact.new(contact_params)
		@contact.user_id = current_user.id
		if @contact.save
		   flash[:notice] = 'お問い合わせを送信しました。'
	     redirect_to users_contact_path(@contact.id)
		else
			 #@contacts = Contact.all
	     #@users = User.all
			 render :new
		end
	end

	def show
    @contact = Contact.find(params[:id])
    @user = @contact.user
  end

	private
	def contact_params
		params.require(:contact).permit(:contact_title, :contact_body, :reply)
	end

end
