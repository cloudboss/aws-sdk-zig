const IcebergSortDirection = @import("iceberg_sort_direction.zig").IcebergSortDirection;
const IcebergNullOrder = @import("iceberg_null_order.zig").IcebergNullOrder;

/// Defines a single sort field in an Iceberg sort order specification.
pub const IcebergSortField = struct {
    /// The sort direction. Valid values are `asc` for ascending order or `desc` for
    /// descending order.
    direction: IcebergSortDirection,

    /// Specifies how null values are ordered. Valid values are `nulls-first` to
    /// place nulls before non-null values, or `nulls-last` to place nulls after
    /// non-null values.
    null_order: IcebergNullOrder,

    /// The ID of the source schema field to sort by. This must reference a valid
    /// field ID from the table schema.
    source_id: i32,

    /// The transform to apply to the source field before sorting. Use `identity` to
    /// sort by the field value directly, or specify other transforms as needed.
    transform: []const u8,

    pub const json_field_names = .{
        .direction = "direction",
        .null_order = "nullOrder",
        .source_id = "sourceId",
        .transform = "transform",
    };
};
