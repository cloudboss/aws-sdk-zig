const ClusterInstanceStatus = @import("cluster_instance_status.zig").ClusterInstanceStatus;

/// Details of an instance in a SageMaker HyperPod cluster.
pub const ClusterInstanceStatusDetails = struct {
    /// The message from an instance in a SageMaker HyperPod cluster.
    message: ?[]const u8,

    /// The status of an instance in a SageMaker HyperPod cluster.
    status: ClusterInstanceStatus,

    pub const json_field_names = .{
        .message = "Message",
        .status = "Status",
    };
};
