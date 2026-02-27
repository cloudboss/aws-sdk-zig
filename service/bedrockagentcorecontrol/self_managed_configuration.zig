const InvocationConfiguration = @import("invocation_configuration.zig").InvocationConfiguration;
const TriggerCondition = @import("trigger_condition.zig").TriggerCondition;

/// A configuration for a self-managed memory strategy.
pub const SelfManagedConfiguration = struct {
    /// The number of historical messages to include in processing context.
    historical_context_window_size: i32,

    /// The configuration to use when invoking memory processing.
    invocation_configuration: InvocationConfiguration,

    /// A list of conditions that trigger memory processing.
    trigger_conditions: []const TriggerCondition,

    pub const json_field_names = .{
        .historical_context_window_size = "historicalContextWindowSize",
        .invocation_configuration = "invocationConfiguration",
        .trigger_conditions = "triggerConditions",
    };
};
