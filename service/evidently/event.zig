const EventType = @import("event_type.zig").EventType;

/// A structure that contains the information about one evaluation event or
/// custom event sent to Evidently. This is a JSON payload. If this event
/// specifies a pre-defined event type, the payload must follow the defined
/// event schema.
pub const Event = struct {
    /// The event data.
    data: []const u8,

    /// The timestamp of the event.
    timestamp: i64,

    /// `aws.evidently.evaluation` specifies an evaluation event, which determines
    /// which feature variation that a user sees. `aws.evidently.custom` specifies a
    /// custom event, which generates metrics from user actions such as clicks and
    /// checkouts.
    @"type": EventType,

    pub const json_field_names = .{
        .data = "data",
        .timestamp = "timestamp",
        .@"type" = "type",
    };
};
