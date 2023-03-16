class SocialNetworksController < ApplicationController
  rescue_from SocialNetworks::FetchData::Unprocessable, with: :unprocessable_entity

  def index
    SocialNetworks::FetchData.new.call do |result|
      result.success { render json: _1 }

      result.failure { head(:unprocessable_entity) }
    end
  end

  def unprocessable_entity(_exception) = head :unprocessable_entity
end
