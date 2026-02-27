const BatchRebootClusterNodesErrorCode = @import("batch_reboot_cluster_nodes_error_code.zig").BatchRebootClusterNodesErrorCode;

/// Represents an error encountered when rebooting a node (identified by its
/// logical node ID) from a SageMaker HyperPod cluster.
pub const BatchRebootClusterNodeLogicalIdsError = struct {
    /// The error code associated with the error encountered when rebooting a node
    /// by logical node ID.
    ///
    /// Possible values:
    ///
    /// * `InstanceIdNotFound`: The node does not exist in the specified cluster.
    /// * `InvalidInstanceStatus`: The node is in a state that does not allow
    ///   rebooting. Wait for the node to finish any ongoing changes before
    ///   retrying.
    /// * `InstanceIdInUse`: Another operation is already in progress for this node.
    ///   Wait for the operation to complete before retrying.
    /// * `InternalServerError`: An internal error occurred while processing this
    ///   node.
    error_code: BatchRebootClusterNodesErrorCode,

    /// A human-readable message describing the error encountered when rebooting a
    /// node by logical node ID.
    message: []const u8,

    /// The logical node ID of the node that encountered an error during the reboot
    /// operation.
    node_logical_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
        .node_logical_id = "NodeLogicalId",
    };
};
