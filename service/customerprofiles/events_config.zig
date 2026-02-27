const EventParameters = @import("event_parameters.zig").EventParameters;

/// Configuration settings that define how events are processed and tracked.
pub const EventsConfig = struct {
    /// A list of event parameters configurations that specify how different event
    /// types should be handled.
    event_parameters_list: []const EventParameters,

    pub const json_field_names = .{
        .event_parameters_list = "EventParametersList",
    };
};
