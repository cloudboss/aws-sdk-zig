const EventReference = @import("event_reference.zig").EventReference;

/// Details about a timeline event during an incident.
pub const EventSummary = struct {
    /// The timeline event ID.
    event_id: []const u8,

    /// A list of references in a `TimelineEvent`.
    event_references: ?[]const EventReference,

    /// The timestamp for when the event occurred.
    event_time: i64,

    /// The type of event. The timeline event must be `Custom Event` or
    /// `Note`.
    event_type: []const u8,

    /// The timestamp for when the timeline event was last updated.
    event_updated_time: i64,

    /// The Amazon Resource Name (ARN) of the incident that the event happened
    /// during.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
        .event_references = "eventReferences",
        .event_time = "eventTime",
        .event_type = "eventType",
        .event_updated_time = "eventUpdatedTime",
        .incident_record_arn = "incidentRecordArn",
    };
};
