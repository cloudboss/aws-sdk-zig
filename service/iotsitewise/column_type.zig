const ScalarType = @import("scalar_type.zig").ScalarType;

/// The data type of the column.
pub const ColumnType = struct {
    /// The allowed data types that the column has as it's value.
    scalar_type: ?ScalarType,

    pub const json_field_names = .{
        .scalar_type = "scalarType",
    };
};
