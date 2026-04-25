const QuotaShareCapacityUtilization = @import("quota_share_capacity_utilization.zig").QuotaShareCapacityUtilization;

/// An object that represents the capacity utilization details of all quota
/// shares associated with a single job queue.
pub const QuotaShareUtilizationDetail = struct {
    /// A list of the top capacity utilizations across quota shares associated with
    /// a job queue.
    top_capacity_utilization: ?[]const QuotaShareCapacityUtilization = null,

    pub const json_field_names = .{
        .top_capacity_utilization = "topCapacityUtilization",
    };
};
