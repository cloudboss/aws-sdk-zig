const ReservedNode = @import("reserved_node.zig").ReservedNode;
const ReservedNodeOffering = @import("reserved_node_offering.zig").ReservedNodeOffering;

/// Details for a reserved-node exchange. Examples include the node type for a
/// reserved node, the price for a node, the node's state, and other details.
pub const ReservedNodeConfigurationOption = struct {
    source_reserved_node: ?ReservedNode = null,

    /// The target reserved-node count.
    target_reserved_node_count: ?i32 = null,

    target_reserved_node_offering: ?ReservedNodeOffering = null,
};
