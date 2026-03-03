const NodeUpdateInitiatedBy = @import("node_update_initiated_by.zig").NodeUpdateInitiatedBy;
const NodeUpdateStatus = @import("node_update_status.zig").NodeUpdateStatus;

/// The status of the service update on the node group member
pub const NodeGroupMemberUpdateStatus = struct {
    /// The cache cluster ID
    cache_cluster_id: ?[]const u8 = null,

    /// The node ID of the cache cluster
    cache_node_id: ?[]const u8 = null,

    /// The deletion date of the node
    node_deletion_date: ?i64 = null,

    /// The end date of the update for a node
    node_update_end_date: ?i64 = null,

    /// Reflects whether the update was initiated by the customer or automatically
    /// applied
    node_update_initiated_by: ?NodeUpdateInitiatedBy = null,

    /// The date when the update is triggered
    node_update_initiated_date: ?i64 = null,

    /// The start date of the update for a node
    node_update_start_date: ?i64 = null,

    /// The update status of the node
    node_update_status: ?NodeUpdateStatus = null,

    /// The date when the NodeUpdateStatus was last modified
    node_update_status_modified_date: ?i64 = null,
};
