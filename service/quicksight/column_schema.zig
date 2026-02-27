/// The column schema.
pub const ColumnSchema = struct {
    /// The data type of the column schema.
    data_type: ?[]const u8,

    /// The geographic role of the column schema.
    geographic_role: ?[]const u8,

    /// The name of the column schema.
    name: ?[]const u8,

    pub const json_field_names = .{
        .data_type = "DataType",
        .geographic_role = "GeographicRole",
        .name = "Name",
    };
};
