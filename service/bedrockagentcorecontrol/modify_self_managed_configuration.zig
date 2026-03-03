const ModifyInvocationConfigurationInput = @import("modify_invocation_configuration_input.zig").ModifyInvocationConfigurationInput;
const TriggerConditionInput = @import("trigger_condition_input.zig").TriggerConditionInput;

/// The configuration for updating the self-managed memory strategy.
pub const ModifySelfManagedConfiguration = struct {
    /// The updated number of historical messages to include in processing context.
    historical_context_window_size: ?i32 = null,

    /// The updated configuration to invoke self-managed memory processing pipeline.
    invocation_configuration: ?ModifyInvocationConfigurationInput = null,

    /// The updated list of conditions that trigger memory processing.
    trigger_conditions: ?[]const TriggerConditionInput = null,

    pub const json_field_names = .{
        .historical_context_window_size = "historicalContextWindowSize",
        .invocation_configuration = "invocationConfiguration",
        .trigger_conditions = "triggerConditions",
    };
};
