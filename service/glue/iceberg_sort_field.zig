const IcebergSortDirection = @import("iceberg_sort_direction.zig").IcebergSortDirection;
const IcebergNullOrder = @import("iceberg_null_order.zig").IcebergNullOrder;

/// Defines a single field within an Iceberg sort order specification, including
/// the source field, transformation, sort direction, and null value ordering.
pub const IcebergSortField = struct {
    /// The sort direction for this field, either ascending or descending.
    direction: IcebergSortDirection,

    /// The ordering behavior for null values in this field, specifying whether
    /// nulls should appear first or last in the sort order.
    null_order: IcebergNullOrder,

    /// The identifier of the source field from the table schema that this sort
    /// field is based on.
    source_id: i32 = 0,

    /// The transformation function applied to the source field before sorting, such
    /// as identity, bucket, or truncate.
    transform: []const u8,

    pub const json_field_names = .{
        .direction = "Direction",
        .null_order = "NullOrder",
        .source_id = "SourceId",
        .transform = "Transform",
    };
};
