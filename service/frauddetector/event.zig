const aws = @import("aws");

const Entity = @import("entity.zig").Entity;

/// The event details.
pub const Event = struct {
    /// The label associated with the event.
    current_label: ?[]const u8,

    /// The event entities.
    entities: ?[]const Entity,

    /// The event ID.
    event_id: ?[]const u8,

    /// The timestamp that defines when the event under evaluation occurred. The
    /// timestamp must be specified using ISO 8601 standard in UTC.
    event_timestamp: ?[]const u8,

    /// The event type.
    event_type_name: ?[]const u8,

    /// Names of the event type's variables you defined in Amazon Fraud Detector to
    /// represent data elements and their corresponding values for the event you are
    /// sending for evaluation.
    event_variables: ?[]const aws.map.StringMapEntry,

    /// The timestamp associated with the label to update. The timestamp must be
    /// specified using ISO 8601 standard in UTC.
    label_timestamp: ?[]const u8,

    pub const json_field_names = .{
        .current_label = "currentLabel",
        .entities = "entities",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .event_type_name = "eventTypeName",
        .event_variables = "eventVariables",
        .label_timestamp = "labelTimestamp",
    };
};
