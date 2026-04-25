const IcebergSortField = @import("iceberg_sort_field.zig").IcebergSortField;

/// Defines the sort order for data within an Iceberg table. Sorting data can
/// improve query performance by enabling more efficient data skipping.
pub const IcebergSortOrder = struct {
    /// The list of sort fields that define how data is sorted within files. Each
    /// field specifies a source field, sort direction, and null ordering. This
    /// field is required if `writeOrder` is provided.
    fields: []const IcebergSortField,

    /// The unique identifier for this sort order. If not specified, defaults to
    /// `1`. The order ID is used by Apache Iceberg to track sort order evolution.
    order_id: i32,

    pub const json_field_names = .{
        .fields = "fields",
        .order_id = "orderId",
    };
};
