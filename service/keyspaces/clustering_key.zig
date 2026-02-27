const SortOrder = @import("sort_order.zig").SortOrder;

/// The optional clustering column portion of your primary key determines how
/// the data is clustered and sorted within each partition.
pub const ClusteringKey = struct {
    /// The name(s) of the clustering column(s).
    name: []const u8,

    /// Sets the ascendant (`ASC`) or descendant (`DESC`) order modifier.
    order_by: SortOrder,

    pub const json_field_names = .{
        .name = "name",
        .order_by = "orderBy",
    };
};
