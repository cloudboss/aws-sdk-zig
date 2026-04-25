const LineageNodeItem = @import("lineage_node_item.zig").LineageNodeItem;

/// Resulting entity from the query.
pub const ResultItem = union(enum) {
    /// Resulting data lineage node from the query.
    lineage_node: ?LineageNodeItem,

    pub const json_field_names = .{
        .lineage_node = "lineageNode",
    };
};
