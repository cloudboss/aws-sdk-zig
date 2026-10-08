const EventActor = @import("event_actor.zig").EventActor;
const SystemEventDetails = @import("system_event_details.zig").SystemEventDetails;
const SystemEventType = @import("system_event_type.zig").SystemEventType;

/// Represents an event in the system event log.
pub const SystemEvent = struct {
    /// The actor that triggered the event.
    actor: EventActor,

    /// The details of the event.
    event_details: SystemEventDetails,

    /// The unique identifier of the event.
    event_id: []const u8,

    /// The type of the event.
    event_type: SystemEventType,

    system_arn: []const u8,

    /// The timestamp of the event.
    timestamp: i64,

    pub const json_field_names = .{
        .actor = "actor",
        .event_details = "eventDetails",
        .event_id = "eventId",
        .event_type = "eventType",
        .system_arn = "systemArn",
        .timestamp = "timestamp",
    };
};
