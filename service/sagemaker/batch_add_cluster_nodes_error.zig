const BatchAddClusterNodesErrorCode = @import("batch_add_cluster_nodes_error_code.zig").BatchAddClusterNodesErrorCode;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;

/// Information about an error that occurred during the node addition operation.
pub const BatchAddClusterNodesError = struct {
    /// The availability zones associated with the failed node addition request.
    availability_zones: ?[]const []const u8 = null,

    /// The error code associated with the failure. Possible values include
    /// `InstanceGroupNotFound` and `InvalidInstanceGroupState`.
    error_code: BatchAddClusterNodesErrorCode,

    /// The number of nodes that failed to be added to the specified instance group.
    failed_count: i32,

    /// The name of the instance group for which the error occurred.
    instance_group_name: []const u8,

    /// The instance types associated with the failed node addition request.
    instance_types: ?[]const ClusterInstanceType = null,

    /// A descriptive message providing additional details about the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .error_code = "ErrorCode",
        .failed_count = "FailedCount",
        .instance_group_name = "InstanceGroupName",
        .instance_types = "InstanceTypes",
        .message = "Message",
    };
};
