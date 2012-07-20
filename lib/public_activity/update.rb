module PublicActivity
  # Handles creation of Activities upon destruction and update of tracked model.
  module Update
    extend ActiveSupport::Concern

    included do
      after_update :activity_on_update
    end   
    private
      # Creates activity upon modification of the tracked model
      def activity_on_update
        settings = prepare_settings
        if get_hook('update').call(self)
          create_activity(settings[:key] || "activity."+self.class.name.parameterize('_')+".update", settings[:owner], settings[:parameters])
        end
      end
  end
end
