const ReservedNodeExchangeStatusType = @import("reserved_node_exchange_status_type.zig").ReservedNodeExchangeStatusType;

/// Reserved-node status details, such as the source reserved-node
/// identifier, the target reserved-node identifier, the node type, the node
/// count, and
/// other details.
pub const ReservedNodeExchangeStatus = struct {
    /// A date and time that indicate when the reserved-node exchange was requested.
    request_time: ?i64 = null,

    /// The identifier of the reserved-node exchange request.
    reserved_node_exchange_request_id: ?[]const u8 = null,

    /// The source reserved-node count in the cluster.
    source_reserved_node_count: ?i32 = null,

    /// The identifier of the source reserved node.
    source_reserved_node_id: ?[]const u8 = null,

    /// The source reserved-node type, for example ra3.4xlarge.
    source_reserved_node_type: ?[]const u8 = null,

    /// The status of the reserved-node exchange request. Statuses include
    /// in-progress and requested.
    status: ?ReservedNodeExchangeStatusType = null,

    /// The count of target reserved nodes in the cluster.
    target_reserved_node_count: ?i32 = null,

    /// The identifier of the target reserved node offering.
    target_reserved_node_offering_id: ?[]const u8 = null,

    /// The node type of the target reserved node, for example ra3.4xlarge.
    target_reserved_node_type: ?[]const u8 = null,
};
