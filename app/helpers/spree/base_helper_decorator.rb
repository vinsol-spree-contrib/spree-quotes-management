module Spree
  module BaseHelper
    def present(model, presenter_class=nil)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self)
    end
  end
end
