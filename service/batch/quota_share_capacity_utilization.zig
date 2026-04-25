const QuotaShareCapacityUsage = @import("quota_share_capacity_usage.zig").QuotaShareCapacityUsage;

/// The capacity utilization for a specific quota share, including the quota
/// share name and its current usage.
pub const QuotaShareCapacityUtilization = struct {
    /// The capacity usage information for this quota share, including the units of
    /// compute capacity and quantity being used.
    capacity_usage: ?[]const QuotaShareCapacityUsage = null,

    /// The name of the quota share.
    quota_share_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_usage = "capacityUsage",
        .quota_share_name = "quotaShareName",
    };
};
