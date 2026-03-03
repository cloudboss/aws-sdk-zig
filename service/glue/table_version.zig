const Table = @import("table.zig").Table;

/// Specifies a version of a table.
pub const TableVersion = struct {
    /// The table in question.
    table: ?Table = null,

    /// The ID value that identifies this table version. A `VersionId` is a string
    /// representation of an integer. Each version is incremented by 1.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .table = "Table",
        .version_id = "VersionId",
    };
};
