class KmController < ApplicationController
  def index
    @groups = ContactGroup.contact_groups(ContactGroup::KM)
  end

  def roles
    @roles = ContactRole.contact_roles
  end

  def birthdays
    @birthdays = ContactBirthday.contact_birthdays
  end
end
