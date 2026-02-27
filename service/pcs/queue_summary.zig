const QueueStatus = @import("queue_status.zig").QueueStatus;

/// The object returned by the `ListQueues` API action.
pub const QueueSummary = struct {
    /// The unique Amazon Resource Name (ARN) of the queue.
    arn: []const u8,

    /// The ID of the cluster of the queue.
    cluster_id: []const u8,

    /// The date and time the resource was created.
    created_at: i64,

    /// The generated unique ID of the queue.
    id: []const u8,

    /// The date and time the resource was modified.
    modified_at: i64,

    /// The name that identifies the queue.
    name: []const u8,

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
        .created_at = "createdAt",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .status = "status",
    };
};
