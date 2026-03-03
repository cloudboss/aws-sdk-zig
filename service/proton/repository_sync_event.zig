/// Repository sync event detail data for a sync attempt.
pub const RepositorySyncEvent = struct {
    /// Event detail for a repository sync attempt.
    event: []const u8,

    /// The external ID of the sync event.
    external_id: ?[]const u8 = null,

    /// The time that the sync event occurred.
    time: i64,

    /// The type of event.
    @"type": []const u8,

    pub const json_field_names = .{
        .event = "event",
        .external_id = "externalId",
        .time = "time",
        .@"type" = "type",
    };
};
