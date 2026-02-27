const DimensionValueType = @import("dimension_value_type.zig").DimensionValueType;

/// This type is used to map column(s) from the query result to a dimension in
/// the
/// destination table.
pub const DimensionMapping = struct {
    /// Type for the dimension.
    dimension_value_type: DimensionValueType,

    /// Column name from query result.
    name: []const u8,

    pub const json_field_names = .{
        .dimension_value_type = "DimensionValueType",
        .name = "Name",
    };
};
