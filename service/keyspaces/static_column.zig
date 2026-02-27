/// The static columns of the table. Static columns store values that are shared
/// by all rows in the same partition.
pub const StaticColumn = struct {
    /// The name of the static column.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
