class ContactsController < ApplicationController
  ACCEPTED_EXTENSIONS = %w(.xlsx .xls .csv).freeze

  def index
    initialize_contacts

    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv }
      format.xls
      format.xlsx
    end
  end

  def search
    initialize_contacts
  end

  def show
    @contact = Contact.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to contacts_path, :notice => 'This entry does not exist!'
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(user_params)

    if @contact.name.length < 1
      redirect_to new_contact_path, :notice => 'Please fill in the information!'
    elsif Contact.exists?(@contact)
        puts "!!!!!!!!!!!!!!!!!"
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
    contact = Contact.find(params[:id])
    contact.destroy
    redirect_to contacts_path, :notice => "Successfully deleted !!"
  end

  def import
    if params[:file].nil?
      redirect_to contacts_database_path, notice: "No file selected"
    elsif !ACCEPTED_EXTENSIONS.include?(File.extname(params[:file].original_filename))
      redirect_to contacts_database_path, notice: "Incompatible file type"
    elsif Contact.import(params[:file])
      redirect_to contacts_path, notice: "Contacts successfully imported!"
    else
      raise 'Please try again'
    end
  end

  #def download
  #  @contacts = Contact.all
  #  respond_to do |format|
  #     format.xlsx {render xlsx: 'download',filename: "contacts.xlsx"}
  #  end
  #end

  private

  def initialize_contacts
    @contacts = if params[:search]
      Contact.search(params[:search])
    else
      Contact.all.order('created_at DESC')
    end
  end

  def user_params
    params.require(:contact).permit(
      :name,
      :birthday,
      :phone,
      :position,
      :sa_yeok,
      :mok_jang,
      :sun_kyo,
      :email,
      :address_building,
      :address_city,
      :address_zip,
      :address_state,
      :other_1,
      :other_2,
      :other_3,
      :image,
      :created_at,
      :updated_at
    )
  end
end
