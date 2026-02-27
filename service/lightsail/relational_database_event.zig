/// Describes an event for a database.
pub const RelationalDatabaseEvent = struct {
    /// The timestamp when the database event was created.
    created_at: ?i64,

    /// The category that the database event belongs to.
    event_categories: ?[]const []const u8,

    /// The message of the database event.
    message: ?[]const u8,

    /// The database that the database event relates to.
    resource: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .event_categories = "eventCategories",
        .message = "message",
        .resource = "resource",
    };
};
