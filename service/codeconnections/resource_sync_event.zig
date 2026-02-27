/// Information about a resource sync event for the resource associated with a
/// sync configuration.
pub const ResourceSyncEvent = struct {
    /// The event for a resource sync event.
    event: []const u8,

    /// The ID for a resource sync event.
    external_id: ?[]const u8,

    /// The time that a resource sync event occurred.
    time: i64,

    /// The type of resource sync event.
    @"type": []const u8,

    pub const json_field_names = .{
        .event = "Event",
        .external_id = "ExternalId",
        .time = "Time",
        .@"type" = "Type",
    };
};
