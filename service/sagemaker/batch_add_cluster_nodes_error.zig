const BatchAddClusterNodesErrorCode = @import("batch_add_cluster_nodes_error_code.zig").BatchAddClusterNodesErrorCode;

/// Information about an error that occurred during the node addition operation.
pub const BatchAddClusterNodesError = struct {
    /// The error code associated with the failure. Possible values include
    /// `InstanceGroupNotFound` and `InvalidInstanceGroupState`.
    error_code: BatchAddClusterNodesErrorCode,

    /// The number of nodes that failed to be added to the specified instance group.
    failed_count: i32,

    /// The name of the instance group for which the error occurred.
    instance_group_name: []const u8,

    /// A descriptive message providing additional details about the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .failed_count = "FailedCount",
        .instance_group_name = "InstanceGroupName",
        .message = "Message",
    };
};
