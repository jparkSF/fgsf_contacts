class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    if params[:search]
        @contacts = Contact.search(params[:search]).order("created_at DESC")
      else
        @contacts = Contact.all.order('created_at DESC')
      end


  end

  def show
    @contact = Contact.find(params[:id])

    rescue ActiveRecord::RecordNotFound => e
    redirect_to contacts_path, :notice => "This entry does not exist!"

  end

  def search
    @contacts = Contact.all
    if params[:search]
        @contacts = Contact.search(params[:search]).order("created_at DESC")
      else
        @contacts = Contact.all.order('created_at DESC')
      end

  end


  def new
    @contact = Contact.new
    
  end

  def create
    @contact = Contact.new(user_params)


      if @contact.name.length < 1
        redirect_to new_contact_path, :notice => "Please fill in the information!"
      elsif @contact.save
        redirect_to contacts_path, :notice => "Successfully Created!"
      else
        render "new"
      end



  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(user_params)
      redirect_to contacts_path, :notice => "Successfully updated!!"
    else
      render "edit"
    end
  end



  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to contacts_path, :notice => "Successfully deleted !!"
  end


  private
  def user_params
    params.require(:contact).permit(:name,:birthday,:phone,:position,:sa_yeok,:mok_jang,:sun_kyo,:email,:address_building,:address_city,:address_zip,:address_state,:other_1,:other_2,:other_3)
  end
end
