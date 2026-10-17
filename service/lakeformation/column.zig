/// A column in a table that a row-level security policy's filter expression can
/// reference.
pub const Column = struct {
    /// The name of the column.
    name: []const u8,

    /// The data type of the column.
    type: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .type = "Type",
    };
};
