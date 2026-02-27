const Resource = @import("resource.zig").Resource;

/// Describes the metadata for a source event.
///
/// For more information, see [Event structure
/// reference](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-events-structure.html) in the *Amazon EventBridge User Guide*.
pub const SourceEventMetadata = struct {
    /// The date and time the source event occurred. This is based on the Source
    /// Event.
    event_occurrence_time: i64,

    /// The Region the event originated from.
    event_origin_region: ?[]const u8,

    /// The type of event. For example, an Amazon CloudWatch state change.
    event_type: []const u8,

    /// The version of the type of event.
    event_type_version: []const u8,

    /// The primary Amazon Web Services account of `SourceEvent`.
    related_account: []const u8,

    /// A list of resources related to this `NotificationEvent`.
    related_resources: []const Resource,

    /// The Amazon Web Services service the event originates from. For example
    /// `aws.cloudwatch`.
    source: []const u8,

    /// The source event id.
    source_event_id: []const u8,

    pub const json_field_names = .{
        .event_occurrence_time = "eventOccurrenceTime",
        .event_origin_region = "eventOriginRegion",
        .event_type = "eventType",
        .event_type_version = "eventTypeVersion",
        .related_account = "relatedAccount",
        .related_resources = "relatedResources",
        .source = "source",
        .source_event_id = "sourceEventId",
    };
};
