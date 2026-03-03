const ImportStatus = @import("import_status.zig").ImportStatus;

/// Contains information about an import that was returned by a lookup request.
pub const ImportsListItem = struct {
    /// The timestamp of the import's creation.
    created_timestamp: ?i64 = null,

    /// The ARN of the destination event data store.
    destinations: ?[]const []const u8 = null,

    /// The ID of the import.
    import_id: ?[]const u8 = null,

    /// The status of the import.
    import_status: ?ImportStatus = null,

    /// The timestamp of the import's last update.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .destinations = "Destinations",
        .import_id = "ImportId",
        .import_status = "ImportStatus",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
