const BatchReplaceClusterNodesErrorCode = @import("batch_replace_cluster_nodes_error_code.zig").BatchReplaceClusterNodesErrorCode;

/// Represents an error encountered when replacing a node in a SageMaker
/// HyperPod cluster.
pub const BatchReplaceClusterNodesError = struct {
    /// The error code associated with the error encountered when replacing a node.
    ///
    /// Possible values:
    ///
    /// * `InstanceIdNotFound`: The instance does not exist in the specified
    ///   cluster.
    /// * `InvalidInstanceStatus`: The instance is in a state that does not allow
    ///   replacement. Wait for the instance to finish any ongoing changes before
    ///   retrying.
    /// * `InstanceIdInUse`: Another operation is already in progress for this node.
    ///   Wait for the operation to complete before retrying.
    /// * `InternalServerError`: An internal error occurred while processing this
    ///   node.
    error_code: BatchReplaceClusterNodesErrorCode,

    /// A human-readable message describing the error encountered when replacing a
    /// node.
    message: []const u8,

    /// The EC2 instance ID of the node that encountered an error during the
    /// replacement operation.
    node_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
        .node_id = "NodeId",
    };
};
