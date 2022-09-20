class Admins::ContactsController < ApplicationController

	def new
    @contact = Contact.new
  end

	def index
		@contacts = Contact.all.order(id: "DESC")
	end

	def create
    @contact = Contact.new(contact_params)
    if @contact.save
       flash[:notice] = "お知らせを投稿しました。"
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
      flash[:notice] = "お知らせを変更しました。"
      redirect_to admins_contact_path(@contact.id)
    else
      render :edit
    end
	end

	def destroy
		@contact = Contact.find(params[:id])
		@contact.destroy
		flash[:notice] = "お知らせを削除しました。"
    redirect_to '/admins/contacts'
	end

	private
	def contact_params
		params.require(:contact).permit(:contact_title, :contact_body)
	end

end
