/// Describes a resize cluster operation. For example, a scheduled action to run
/// the `ResizeCluster` API operation.
pub const ResizeClusterMessage = struct {
    /// A boolean value indicating whether the resize operation is using the classic
    /// resize
    /// process. If you don't provide this parameter or set the value to
    /// `false`, the resize type is elastic.
    classic: ?bool,

    /// The unique identifier for the cluster to resize.
    cluster_identifier: []const u8,

    /// The new cluster type for the specified cluster.
    cluster_type: ?[]const u8,

    /// The new node type for the nodes you are adding. If not specified, the
    /// cluster's current node type is used.
    node_type: ?[]const u8,

    /// The new number of nodes for the cluster. If not specified, the cluster's
    /// current number of nodes is used.
    number_of_nodes: ?i32,

    /// The identifier of the reserved node.
    reserved_node_id: ?[]const u8,

    /// The identifier of the target reserved node offering.
    target_reserved_node_offering_id: ?[]const u8,
};
