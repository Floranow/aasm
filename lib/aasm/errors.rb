module AASM

  class UnknownStateMachineError < RuntimeError; end

  class InvalidTransition < RuntimeError
    attr_reader :object, :event_name, :originating_state, :failures, :state_machine_name

    def initialize(object, event_name, state_machine_name, failures = [], custom_message = nil)
      @object, @event_name, @originating_state, @failures, @custom_message = object, event_name, object.aasm(state_machine_name).current_state, failures, custom_message
      @state_machine_name = state_machine_name
      super("Event '#{event_name}' cannot transition from '#{originating_state}'.#{reasoning}") unless custom_message.present?

    end

    def reasoning
      " Failed callback(s): #{failures}." unless failures.empty?
    end
    def message
      @custom_message
    end
  end

  class UndefinedState < RuntimeError; end
  class NoDirectAssignmentError < RuntimeError; end
end
