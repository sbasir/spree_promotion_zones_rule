module Spree
  module Api
    ZonesController.class_eval do
  
      def index
        if params[:ids]
          @zones = Zone.accessible_by(current_ability, :read).order('name ASC').where(:id => params[:ids].split(","))
        else
          @zones = Zone.accessible_by(current_ability, :read).order('name ASC').ransack(params[:q]).result
        end
        @zones = @zones.page(params[:page]).per(params[:per_page])
        respond_with(@zones)
      end

    end
  end
end