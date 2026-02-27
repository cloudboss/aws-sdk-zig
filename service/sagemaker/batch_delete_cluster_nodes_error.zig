const BatchDeleteClusterNodesErrorCode = @import("batch_delete_cluster_nodes_error_code.zig").BatchDeleteClusterNodesErrorCode;

/// Represents an error encountered when deleting a node from a SageMaker
/// HyperPod cluster.
pub const BatchDeleteClusterNodesError = struct {
    /// The error code associated with the error encountered when deleting a node.
    ///
    /// The code provides information about the specific issue encountered, such as
    /// the node not being found, the node's status being invalid for deletion, or
    /// the node ID being in use by another process.
    code: BatchDeleteClusterNodesErrorCode,

    /// A message describing the error encountered when deleting a node.
    message: []const u8,

    /// The ID of the node that encountered an error during the deletion process.
    node_id: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .node_id = "NodeId",
    };
};
