const EksAttemptContainerDetail = @import("eks_attempt_container_detail.zig").EksAttemptContainerDetail;

/// An object that represents the details of a job attempt for a job attempt by
/// an Amazon EKS
/// container.
pub const EksAttemptDetail = struct {
    /// The details for the final status of the containers for this job attempt.
    containers: ?[]const EksAttemptContainerDetail = null,

    /// The Amazon Resource Name (ARN) of the Amazon EKS cluster.
    eks_cluster_arn: ?[]const u8 = null,

    /// The details for the init containers.
    init_containers: ?[]const EksAttemptContainerDetail = null,

    /// The name of the node for this job attempt.
    node_name: ?[]const u8 = null,

    /// The name of the pod for this job attempt.
    pod_name: ?[]const u8 = null,

    /// The namespace of the Amazon EKS cluster that the pod exists in.
    pod_namespace: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the attempt was started (when
    /// the attempt
    /// transitioned from the `STARTING` state to the `RUNNING` state).
    started_at: ?i64 = null,

    /// A short, human-readable string to provide additional details for the current
    /// status of the
    /// job attempt.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the attempt was stopped. This
    /// happens when the
    /// attempt transitioned from the `RUNNING` state to a terminal state, such as
    /// `SUCCEEDED` or `FAILED`.
    stopped_at: ?i64 = null,

    pub const json_field_names = .{
        .containers = "containers",
        .eks_cluster_arn = "eksClusterArn",
        .init_containers = "initContainers",
        .node_name = "nodeName",
        .pod_name = "podName",
        .pod_namespace = "podNamespace",
        .started_at = "startedAt",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
    };
};
