module Opinio
  module Controllers
    module Extensions
      extend ActiveSupport::Concern

      included do
        (class << self; self; end).instance_eval do
          define_method "#{Opinio.model_name.underscore}_destroy_conditions" do |&block|
            Opinio.set_destroy_conditions( &block )
          end
        end
      end

      module ClassMethods
        def opinio_identifier(&block)
          Opinio.opinio_identifier(block)
        end
      end

      module InstanceMethods
        def can_destroy_opinio?(opinio)
          self.instance_exec(opinio, &Opinio.destroy_conditions)
        end
      end
    end
  end
end
