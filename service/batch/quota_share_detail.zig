const QuotaShareCapacityLimit = @import("quota_share_capacity_limit.zig").QuotaShareCapacityLimit;
const QuotaSharePreemptionConfiguration = @import("quota_share_preemption_configuration.zig").QuotaSharePreemptionConfiguration;
const QuotaShareResourceSharingConfiguration = @import("quota_share_resource_sharing_configuration.zig").QuotaShareResourceSharingConfiguration;
const QuotaShareState = @import("quota_share_state.zig").QuotaShareState;
const QuotaShareStatus = @import("quota_share_status.zig").QuotaShareStatus;

/// Detailed information about a quota share, including its configuration,
/// state, and capacity limits.
pub const QuotaShareDetail = struct {
    /// A list that specifies the quantity and type of compute capacity allocated to
    /// the quota share.
    capacity_limits: ?[]const QuotaShareCapacityLimit = null,

    /// The Amazon Resource Name (ARN) of the job queue associated with the quota
    /// share.
    job_queue_arn: ?[]const u8 = null,

    /// Specifies the preemption behavior for jobs in a quota share.
    preemption_configuration: ?QuotaSharePreemptionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the quota share.
    quota_share_arn: ?[]const u8 = null,

    /// The name of the quota share.
    quota_share_name: ?[]const u8 = null,

    /// Specifies whether a quota share reserves, lends, or both lends and borrows
    /// idle compute capacity.
    resource_sharing_configuration: ?QuotaShareResourceSharingConfiguration = null,

    /// The state of the quota share.
    state: ?QuotaShareState = null,

    /// The current status of the quota share.
    status: ?QuotaShareStatus = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .job_queue_arn = "jobQueueArn",
        .preemption_configuration = "preemptionConfiguration",
        .quota_share_arn = "quotaShareArn",
        .quota_share_name = "quotaShareName",
        .resource_sharing_configuration = "resourceSharingConfiguration",
        .state = "state",
        .status = "status",
    };
};
