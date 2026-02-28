/// Contains metadata for a column in a table.
pub const Column = struct {
    /// Optional information about the column.
    comment: ?[]const u8,

    /// The name of the column.
    name: []const u8,

    /// The data type of the column.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .comment = "Comment",
        .name = "Name",
        .@"type" = "Type",
    };
};
