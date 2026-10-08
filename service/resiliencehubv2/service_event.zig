const EventActor = @import("event_actor.zig").EventActor;
const ServiceEventDetails = @import("service_event_details.zig").ServiceEventDetails;
const ServiceEventType = @import("service_event_type.zig").ServiceEventType;

/// Represents an event in the service event log.
pub const ServiceEvent = struct {
    /// The actor that triggered the event.
    actor: EventActor,

    /// The details of the event.
    event_details: ServiceEventDetails,

    /// The unique identifier of the event.
    event_id: []const u8,

    /// The type of the event.
    event_type: ServiceEventType,

    service_arn: []const u8,

    /// The timestamp of the event.
    timestamp: i64,

    pub const json_field_names = .{
        .actor = "actor",
        .event_details = "eventDetails",
        .event_id = "eventId",
        .event_type = "eventType",
        .service_arn = "serviceArn",
        .timestamp = "timestamp",
    };
};
