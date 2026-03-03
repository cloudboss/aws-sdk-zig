/// A structure describing the name, data type, and geographic role of the
/// columns.
pub const ColumnGroupColumnSchema = struct {
    /// The name of the column group's column schema.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
