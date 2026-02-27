const NodeUpdateInitiatedBy = @import("node_update_initiated_by.zig").NodeUpdateInitiatedBy;
const NodeUpdateStatus = @import("node_update_status.zig").NodeUpdateStatus;

/// The status of the service update on the cache node
pub const CacheNodeUpdateStatus = struct {
    /// The node ID of the cache cluster
    cache_node_id: ?[]const u8,

    /// The deletion date of the node
    node_deletion_date: ?i64,

    /// The end date of the update for a node
    node_update_end_date: ?i64,

    /// Reflects whether the update was initiated by the customer or automatically
    /// applied
    node_update_initiated_by: ?NodeUpdateInitiatedBy,

    /// The date when the update is triggered
    node_update_initiated_date: ?i64,

    /// The start date of the update for a node
    node_update_start_date: ?i64,

    /// The update status of the node
    node_update_status: ?NodeUpdateStatus,

    /// The date when the NodeUpdateStatus was last modified>
    node_update_status_modified_date: ?i64,
};
