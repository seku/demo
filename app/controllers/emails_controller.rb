class EmailsController < ApplicationController
  def index
    @user = User.all
    @user.each {|u| PostMailer.deliver_confirm(u)}
    redirect_to emails_path

  end

end
