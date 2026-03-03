const InvocationConfigurationInput = @import("invocation_configuration_input.zig").InvocationConfigurationInput;
const TriggerConditionInput = @import("trigger_condition_input.zig").TriggerConditionInput;

/// Input configuration for a self-managed memory strategy.
pub const SelfManagedConfigurationInput = struct {
    /// Number of historical messages to include in processing context.
    historical_context_window_size: i32 = 4,

    /// Configuration to invoke a self-managed memory processing pipeline with.
    invocation_configuration: InvocationConfigurationInput,

    /// A list of conditions that trigger memory processing.
    trigger_conditions: ?[]const TriggerConditionInput = null,

    pub const json_field_names = .{
        .historical_context_window_size = "historicalContextWindowSize",
        .invocation_configuration = "invocationConfiguration",
        .trigger_conditions = "triggerConditions",
    };
};
