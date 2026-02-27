const ChangeType = @import("change_type.zig").ChangeType;

/// A list of change request objects.
pub const ChangeRequest = struct {
    /// Defines the type of change request. A `changeType` can have the following
    /// values:
    ///
    /// * PUT – Adds or updates files in a database.
    ///
    /// * DELETE – Deletes files in a database.
    change_type: ChangeType,

    /// Defines the path within the database directory.
    db_path: []const u8,

    /// Defines the S3 path of the source file that is required to add or update
    /// files in a database.
    s_3_path: ?[]const u8,

    pub const json_field_names = .{
        .change_type = "changeType",
        .db_path = "dbPath",
        .s_3_path = "s3Path",
    };
};
