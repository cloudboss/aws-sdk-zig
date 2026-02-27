const EventParameters = @import("event_parameters.zig").EventParameters;

/// Describes the configuration of events, which are used in solution creation.
pub const EventsConfig = struct {
    /// A list of event parameters, which includes event types and their event value
    /// thresholds and weights.
    event_parameters_list: ?[]const EventParameters,

    pub const json_field_names = .{
        .event_parameters_list = "eventParametersList",
    };
};
