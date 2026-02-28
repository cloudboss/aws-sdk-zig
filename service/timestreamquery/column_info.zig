const Type = @import("type.zig").Type;

/// Contains the metadata for query results such as the column names, data
/// types, and
/// other attributes.
pub const ColumnInfo = struct {
    /// The name of the result set column. The name of the result set is available
    /// for
    /// columns of all data types except for arrays.
    name: ?[]const u8,

    /// The data type of the result set column. The data type can be a scalar or
    /// complex.
    /// Scalar data types are integers, strings, doubles, Booleans, and others.
    /// Complex data
    /// types are types such as arrays, rows, and others.
    @"type": ?*Type = null,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
