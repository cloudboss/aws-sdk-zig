const BatchRebootClusterNodesErrorCode = @import("batch_reboot_cluster_nodes_error_code.zig").BatchRebootClusterNodesErrorCode;

/// Represents an error encountered when rebooting a node from a SageMaker
/// HyperPod cluster.
pub const BatchRebootClusterNodesError = struct {
    /// The error code associated with the error encountered when rebooting a node.
    ///
    /// Possible values:
    ///
    /// * `InstanceIdNotFound`: The instance does not exist in the specified
    ///   cluster.
    /// * `InvalidInstanceStatus`: The instance is in a state that does not allow
    ///   rebooting. Wait for the instance to finish any ongoing changes before
    ///   retrying.
    /// * `InstanceIdInUse`: Another operation is already in progress for this node.
    ///   Wait for the operation to complete before retrying.
    /// * `InternalServerError`: An internal error occurred while processing this
    ///   node.
    error_code: BatchRebootClusterNodesErrorCode,

    /// A human-readable message describing the error encountered when rebooting a
    /// node.
    message: []const u8,

    /// The EC2 instance ID of the node that encountered an error during the reboot
    /// operation.
    node_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
        .node_id = "NodeId",
    };
};
