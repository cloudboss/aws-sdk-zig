const FairshareUtilizationDetail = @import("fairshare_utilization_detail.zig").FairshareUtilizationDetail;
const QuotaShareUtilizationDetail = @import("quota_share_utilization_detail.zig").QuotaShareUtilizationDetail;
const QueueSnapshotCapacityUsage = @import("queue_snapshot_capacity_usage.zig").QueueSnapshotCapacityUsage;

/// The job queue utilization at a specific point in time,
/// including total capacity usage, and quota share or fairshare utilization
/// breakdown
/// depending on the job queue scheduling policy.
pub const QueueSnapshotUtilizationDetail = struct {
    /// The utilization information for a fairshare scheduling job queues, including
    /// active share count and top capacity utilization by share.
    fairshare_utilization: ?FairshareUtilizationDetail = null,

    /// The Unix timestamp (in milliseconds) for when the queue utilization
    /// information was
    /// last updated.
    last_updated_at: ?i64 = null,

    /// The utilization information for a job queue with a quota share scheduling
    /// policy.
    quota_share_utilization: ?QuotaShareUtilizationDetail = null,

    /// The total capacity usage for the entire job queue.
    total_capacity_usage: ?[]const QueueSnapshotCapacityUsage = null,

    pub const json_field_names = .{
        .fairshare_utilization = "fairshareUtilization",
        .last_updated_at = "lastUpdatedAt",
        .quota_share_utilization = "quotaShareUtilization",
        .total_capacity_usage = "totalCapacityUsage",
    };
};
