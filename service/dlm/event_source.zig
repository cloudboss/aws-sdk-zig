const EventParameters = @import("event_parameters.zig").EventParameters;
const EventSourceValues = @import("event_source_values.zig").EventSourceValues;

/// **[Event-based policies only]** Specifies an event that activates an
/// event-based policy.
pub const EventSource = struct {
    /// Information about the event.
    parameters: ?EventParameters,

    /// The source of the event. Currently only managed CloudWatch Events rules are
    /// supported.
    type: EventSourceValues,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .type = "Type",
    };
};
