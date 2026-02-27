const IcebergSortField = @import("iceberg_sort_field.zig").IcebergSortField;

/// Defines the sort order specification for an Iceberg table, determining how
/// data should be ordered within partitions to
/// optimize query performance.
pub const IcebergSortOrder = struct {
    /// The list of fields and their sort directions that define the ordering
    /// criteria for the Iceberg table data.
    fields: []const IcebergSortField,

    /// The unique identifier for this sort order specification within the Iceberg
    /// table's metadata.
    order_id: i32 = 0,

    pub const json_field_names = .{
        .fields = "Fields",
        .order_id = "OrderId",
    };
};
