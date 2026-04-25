const FairshareCapacityUtilization = @import("fairshare_capacity_utilization.zig").FairshareCapacityUtilization;

/// The fairshare utilization for a job queue, including the number
/// of active shares and top capacity utilization.
pub const FairshareUtilizationDetail = struct {
    /// The total number of active shares in the fairshare scheduling job queue that
    /// are
    /// currently utilizing capacity.
    active_share_count: ?i64 = null,

    /// A list of the top 20 shares with the highest capacity utilization, ordered
    /// by usage
    /// amount.
    top_capacity_utilization: ?[]const FairshareCapacityUtilization = null,

    pub const json_field_names = .{
        .active_share_count = "activeShareCount",
        .top_capacity_utilization = "topCapacityUtilization",
    };
};
