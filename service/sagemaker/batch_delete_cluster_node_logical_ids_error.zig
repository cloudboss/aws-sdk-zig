const BatchDeleteClusterNodesErrorCode = @import("batch_delete_cluster_nodes_error_code.zig").BatchDeleteClusterNodesErrorCode;

/// Information about an error that occurred when attempting to delete a node
/// identified by its `NodeLogicalId`.
pub const BatchDeleteClusterNodeLogicalIdsError = struct {
    /// The error code associated with the failure. Possible values include
    /// `NodeLogicalIdNotFound`, `InvalidNodeStatus`, and `InternalError`.
    code: BatchDeleteClusterNodesErrorCode,

    /// A descriptive message providing additional details about the error.
    message: []const u8,

    /// The `NodeLogicalId` of the node that could not be deleted.
    node_logical_id: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .node_logical_id = "NodeLogicalId",
    };
};
