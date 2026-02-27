const ComputeNodeGroupConfiguration = @import("compute_node_group_configuration.zig").ComputeNodeGroupConfiguration;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const QueueSlurmConfiguration = @import("queue_slurm_configuration.zig").QueueSlurmConfiguration;
const QueueStatus = @import("queue_status.zig").QueueStatus;

/// A queue resource.
pub const Queue = struct {
    /// The unique Amazon Resource Name (ARN) of the queue.
    arn: []const u8,

    /// The ID of the cluster of the queue.
    cluster_id: []const u8,

    /// The list of compute node group configurations associated with the queue.
    /// Queues assign jobs to associated compute node groups.
    compute_node_group_configurations: []const ComputeNodeGroupConfiguration,

    /// The date and time the resource was created.
    created_at: i64,

    /// The list of errors that occurred during queue provisioning.
    error_info: ?[]const ErrorInfo,

    /// The generated unique ID of the queue.
    id: []const u8,

    /// The date and time the resource was modified.
    modified_at: i64,

    /// The name that identifies the queue.
    name: []const u8,

    /// Additional options related to the Slurm scheduler.
    slurm_configuration: ?QueueSlurmConfiguration,

    /// The provisioning status of the queue.
    ///
    /// The provisioning status doesn't indicate the overall health of the queue.
    ///
    /// The resource enters the `SUSPENDING` and `SUSPENDED` states when the
    /// scheduler is beyond end of life and we have suspended the cluster. When in
    /// these states, you can't use the cluster. The cluster controller is down and
    /// all compute instances are terminated. The resources still count toward your
    /// service quotas. You can delete a resource if its status is `SUSPENDED`. For
    /// more information, see [Frequently asked questions about Slurm versions in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-versions_faq.html) in the *PCS User Guide*.
    status: QueueStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .cluster_id = "clusterId",
        .compute_node_group_configurations = "computeNodeGroupConfigurations",
        .created_at = "createdAt",
        .error_info = "errorInfo",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .slurm_configuration = "slurmConfiguration",
        .status = "status",
    };
};
