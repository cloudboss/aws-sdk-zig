const EventActor = @import("event_actor.zig").EventActor;
const PolicyEventDetails = @import("policy_event_details.zig").PolicyEventDetails;
const PolicyEventType = @import("policy_event_type.zig").PolicyEventType;

/// An event on the timeline of a resilience policy.
pub const PolicyEvent = struct {
    actor: EventActor,

    /// The details of the event.
    event_details: PolicyEventDetails,

    /// The identifier of the event.
    event_id: []const u8,

    /// The type of the event.
    event_type: PolicyEventType,

    policy_arn: []const u8,

    /// The time the event occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .actor = "actor",
        .event_details = "eventDetails",
        .event_id = "eventId",
        .event_type = "eventType",
        .policy_arn = "policyArn",
        .timestamp = "timestamp",
    };
};
