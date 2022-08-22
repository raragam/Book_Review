class Admins::ContactsController < ApplicationController

	def new
    @contact = Contact.new
  end

	def index
		@contacts = Contact.all
	end

	def create
    @contact = Contact.new(contact_params)
    if @contact.save
       flash[:notice] = "通達を投稿しました。"
       redirect_to admins_contact_path(@contact.id)
    else
       render :new
    end
  end

  def show
    @contact = Contact.find(params[:id])
    @contacts = Contact.all
  end

	def edit
		@contact = Contact.find(params[:id])
	end

	def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:notice] = "通達を変更しました。"
      redirect_to admins_contact_path(@contact.id)
    else
      render :edit
    end
	end

	def destroy
		@contact = Contact.find(params[:id])
		@contact.destroy
		flash[:notice] = "通達を削除しました。"
    redirect_to '/admins/contacts'
	end

	private
	def contact_params
		params.require(:contact).permit(:contact_title, :contact_body)
	end

end
