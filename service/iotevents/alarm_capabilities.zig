const AcknowledgeFlow = @import("acknowledge_flow.zig").AcknowledgeFlow;
const InitializationConfiguration = @import("initialization_configuration.zig").InitializationConfiguration;

/// Contains the configuration information of alarm state changes.
pub const AlarmCapabilities = struct {
    /// Specifies whether to get notified for alarm state changes.
    acknowledge_flow: ?AcknowledgeFlow,

    /// Specifies the default alarm state.
    /// The configuration applies to all alarms that were created based on this
    /// alarm model.
    initialization_configuration: ?InitializationConfiguration,

    pub const json_field_names = .{
        .acknowledge_flow = "acknowledgeFlow",
        .initialization_configuration = "initializationConfiguration",
    };
};
