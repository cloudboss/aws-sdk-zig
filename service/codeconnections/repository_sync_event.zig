/// Information about a repository sync event.
pub const RepositorySyncEvent = struct {
    /// A description of a repository sync event.
    event: []const u8,

    /// The ID for a repository sync event.
    external_id: ?[]const u8 = null,

    /// The time that a repository sync event occurred.
    time: i64,

    /// The event type for a repository sync event.
    @"type": []const u8,

    pub const json_field_names = .{
        .event = "Event",
        .external_id = "ExternalId",
        .time = "Time",
        .@"type" = "Type",
    };
};
