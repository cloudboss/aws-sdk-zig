const Endpoint = @import("endpoint.zig").Endpoint;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const Networking = @import("networking.zig").Networking;
const Scheduler = @import("scheduler.zig").Scheduler;
const Size = @import("size.zig").Size;
const ClusterSlurmConfiguration = @import("cluster_slurm_configuration.zig").ClusterSlurmConfiguration;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

/// The cluster resource and configuration.
pub const Cluster = struct {
    /// The unique Amazon Resource Name (ARN) of the cluster.
    arn: []const u8,

    /// The date and time the resource was created.
    created_at: i64,

    /// The list of endpoints available for interaction with the scheduler.
    endpoints: ?[]const Endpoint = null,

    /// The list of errors that occurred during cluster provisioning.
    error_info: ?[]const ErrorInfo = null,

    /// The generated unique ID of the cluster.
    id: []const u8,

    /// The date and time the resource was modified.
    modified_at: i64,

    /// The name that identifies the cluster.
    name: []const u8,

    networking: Networking,

    scheduler: Scheduler,

    /// The size of the cluster.
    ///
    /// * `SMALL`: 32 compute nodes and 256 jobs
    /// * `MEDIUM`: 512 compute nodes and 8192 jobs
    /// * `LARGE`: 2048 compute nodes and 16,384 jobs
    size: Size,

    /// Additional options related to the Slurm scheduler.
    slurm_configuration: ?ClusterSlurmConfiguration = null,

    /// The provisioning status of the cluster.
    ///
    /// The provisioning status doesn't indicate the overall health of the cluster.
    ///
    /// The resource enters the `SUSPENDING` and `SUSPENDED` states when the
    /// scheduler is beyond end of life and we have suspended the cluster. When in
    /// these states, you can't use the cluster. The cluster controller is down and
    /// all compute instances are terminated. The resources still count toward your
    /// service quotas. You can delete a resource if its status is `SUSPENDED`. For
    /// more information, see [Frequently asked questions about Slurm versions in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-versions_faq.html) in the *PCS User Guide*.
    status: ClusterStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .endpoints = "endpoints",
        .error_info = "errorInfo",
        .id = "id",
        .modified_at = "modifiedAt",
        .name = "name",
        .networking = "networking",
        .scheduler = "scheduler",
        .size = "size",
        .slurm_configuration = "slurmConfiguration",
        .status = "status",
    };
};
