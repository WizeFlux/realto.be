class BookingMailer < ActionMailer::Base
  def placement_success(booking)
    @booking = booking
    mail(
      :from => booking.agency.contacts.where(kind: 'Email').first.entry,
      :bcc => booking.agency.contacts.where(kind: 'Email').map(&:entry),
      :to => booking.email
    )
  end
end
