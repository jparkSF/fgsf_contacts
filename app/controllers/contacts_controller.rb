class ContactsController < ApplicationController
  ACCEPTED_EXTENSIONS = %w(.xlsx .xls .csv).freeze

  def index
    initialize_all_contacts

    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv }
      format.xls
      format.xlsx
    end
  end

  def search
    initialize_all_contacts
  end

  def show
    initialize_contact
  rescue ActiveRecord::RecordNotFound
    redirect_to contacts_path, :notice => 'This entry does not exist.'
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create!(user_params)
    redirect_to contacts_path, :notice => 'Successfully Created.'
  rescue => e
    # Captures any exceptions and display error message on page
    flash[:notice] = e.message
    render 'new'
  end

  def edit
    initialize_contact
  end

  def update
    initialize_contact
    @contact.update_attributes!(user_params)
    #redirect_to contacts_path, :notice => 'Successfully updated.'
    redirect_to show, :notice => 'Successfully updated.'

  rescue => e
    # Captures any exceptions and display error message on page
    flash[:notice] = e.message
    render 'edit'
  end

  def destroy
    initialize_contact
    @contact.destroy!
    redirect_to contacts_path, :notice => 'Successfully deleted.'
  rescue => e
    # Captures any exceptions and display error message on page
    flash[:notice] = e.message
    render 'show'
  end

  def import
    if params[:file].nil?
      redirect_to contacts_database_path, notice: 'No file selected'
    elsif !ACCEPTED_EXTENSIONS.include?(File.extname(params[:file].original_filename))
      redirect_to contacts_database_path, notice: 'Incompatible file type'
    else
      Contact.import(params[:file])
      redirect_to contacts_path, notice: 'Contacts successfully imported!'
    end
  end

  #def download
  #  @contacts = Contact.all
  #  respond_to do |format|
  #     format.xlsx {render xlsx: 'download',filename: "contacts.xlsx"}
  #  end
  #end

  private

  def initialize_contact
    @contact = Contact.find(params[:id])
  end

  def initialize_all_contacts
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
