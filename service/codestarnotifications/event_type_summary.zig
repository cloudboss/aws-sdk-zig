/// Returns information about an event that has triggered a notification rule.
pub const EventTypeSummary = struct {
    /// The system-generated ID of the event. For a complete list of event types and
    /// IDs, see
    /// [Notification
    /// concepts](https://docs.aws.amazon.com/codestar-notifications/latest/userguide/concepts.html#concepts-api)
    /// in the *Developer Tools Console User Guide*.
    event_type_id: ?[]const u8,

    /// The name of the event.
    event_type_name: ?[]const u8,

    /// The resource type of the event.
    resource_type: ?[]const u8,

    /// The name of the service for which the event applies.
    service_name: ?[]const u8,

    pub const json_field_names = .{
        .event_type_id = "EventTypeId",
        .event_type_name = "EventTypeName",
        .resource_type = "ResourceType",
        .service_name = "ServiceName",
    };
};
