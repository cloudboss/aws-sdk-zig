const Row = @import("row.zig").Row;

/// Represents a single data point in a query result.
pub const Datum = struct {
    /// Indicates if the data point is an array.
    array_value: ?[]const Datum,

    /// Indicates if the data point is null.
    null_value: ?bool,

    /// Indicates if the data point is a row.
    row_value: ?*Row = null,

    /// Indicates if the data point is a scalar value such as integer, string,
    /// double, or Boolean.
    scalar_value: ?[]const u8,

    pub const json_field_names = .{
        .array_value = "arrayValue",
        .null_value = "nullValue",
        .row_value = "rowValue",
        .scalar_value = "scalarValue",
    };
};
