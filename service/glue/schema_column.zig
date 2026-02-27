/// A key-value pair representing a column and data type that this transform can
/// run against. The `Schema` parameter of the `MLTransform` may contain up to
/// 100 of these structures.
pub const SchemaColumn = struct {
    /// The type of data in the column.
    data_type: ?[]const u8,

    /// The name of the column.
    name: ?[]const u8,

    pub const json_field_names = .{
        .data_type = "DataType",
        .name = "Name",
    };
};
