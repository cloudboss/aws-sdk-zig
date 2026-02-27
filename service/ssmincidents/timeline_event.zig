const EventReference = @import("event_reference.zig").EventReference;

/// A significant event that happened during the incident.
pub const TimelineEvent = struct {
    /// A short description of the event.
    event_data: []const u8,

    /// The ID of the timeline event.
    event_id: []const u8,

    /// A list of references in a `TimelineEvent`.
    event_references: ?[]const EventReference,

    /// The timestamp for when the event occurred.
    event_time: i64,

    /// The type of event that occurred. Currently Incident Manager supports only
    /// the `Custom
    /// Event` and `Note` types.
    event_type: []const u8,

    /// The timestamp for when the timeline event was last updated.
    event_updated_time: i64,

    /// The Amazon Resource Name (ARN) of the incident that the event occurred
    /// during.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .event_data = "eventData",
        .event_id = "eventId",
        .event_references = "eventReferences",
        .event_time = "eventTime",
        .event_type = "eventType",
        .event_updated_time = "eventUpdatedTime",
        .incident_record_arn = "incidentRecordArn",
    };
};
