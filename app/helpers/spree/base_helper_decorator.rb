module Spree
  module BaseHelper
    def present(model, presenter_class=nil)
      klass = presenter_class || "#{model.class}Presenter".constantize
      presenter = klass.new(model, self)
    end

    def quote_states
      Spree::Quote.state_machines[:state].states.map {|s| [Spree.t("quote_state.#{s.name}"), s.value]}
    end
  end
end
