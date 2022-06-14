# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database, format: :to_database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #

  param :message

  def message
    params[:message]
  end

  def to_database
    {
      type: self.class.name,
      params: params
    }
  end

  # def message
  #   t(".message")
  # end
  def url
    notifications_index_path(params[:message])
  end
end
