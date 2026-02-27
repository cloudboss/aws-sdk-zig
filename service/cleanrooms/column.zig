/// A column within a schema relation, derived from the underlying table.
pub const Column = struct {
    /// The name of the column.
    name: []const u8,

    /// The type of the column.
    type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
