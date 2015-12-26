class PagesController < ApplicationController

  def index

  end


    before_action :authenticate_user!, only: [:secret]


end
