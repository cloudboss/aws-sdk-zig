const ActivationState = @import("activation_state.zig").ActivationState;
const ComputeQuotaConfig = @import("compute_quota_config.zig").ComputeQuotaConfig;
const ComputeQuotaTarget = @import("compute_quota_target.zig").ComputeQuotaTarget;
const SchedulerResourceStatus = @import("scheduler_resource_status.zig").SchedulerResourceStatus;

/// Summary of the compute allocation definition.
pub const ComputeQuotaSummary = struct {
    /// The state of the compute allocation being described. Use to enable or
    /// disable compute allocation.
    ///
    /// Default is `Enabled`.
    activation_state: ?ActivationState,

    /// ARN of the cluster.
    cluster_arn: ?[]const u8,

    /// ARN of the compute allocation definition.
    compute_quota_arn: []const u8,

    /// Configuration of the compute allocation definition. This includes the
    /// resource sharing option, and the setting to preempt low priority tasks.
    compute_quota_config: ?ComputeQuotaConfig,

    /// ID of the compute allocation definition.
    compute_quota_id: []const u8,

    /// The target entity to allocate compute resources to.
    compute_quota_target: ComputeQuotaTarget,

    /// Version of the compute allocation definition.
    compute_quota_version: ?i32,

    /// Creation time of the compute allocation definition.
    creation_time: i64,

    /// Last modified time of the compute allocation definition.
    last_modified_time: ?i64,

    /// Name of the compute allocation definition.
    name: []const u8,

    /// Status of the compute allocation definition.
    status: SchedulerResourceStatus,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
        .cluster_arn = "ClusterArn",
        .compute_quota_arn = "ComputeQuotaArn",
        .compute_quota_config = "ComputeQuotaConfig",
        .compute_quota_id = "ComputeQuotaId",
        .compute_quota_target = "ComputeQuotaTarget",
        .compute_quota_version = "ComputeQuotaVersion",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};
