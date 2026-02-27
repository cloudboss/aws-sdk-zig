const aws = @import("aws");

/// The summary of the event trigger.
pub const EventTriggerSummaryItem = struct {
    /// The timestamp of when the event trigger was created.
    created_at: ?i64,

    /// The description of the event trigger.
    description: ?[]const u8,

    /// The unique name of the event trigger.
    event_trigger_name: ?[]const u8,

    /// The timestamp of when the event trigger was most recently updated.
    last_updated_at: ?i64,

    /// The unique name of the object type.
    object_type_name: ?[]const u8,

    /// An array of key-value pairs to apply to this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .event_trigger_name = "EventTriggerName",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .tags = "Tags",
    };
};
