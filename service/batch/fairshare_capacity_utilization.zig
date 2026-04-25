const FairshareCapacityUsage = @import("fairshare_capacity_usage.zig").FairshareCapacityUsage;

/// The capacity utilization for a specific share in a fairshare scheduling job
/// queue, including the share identifier and its current usage.
pub const FairshareCapacityUtilization = struct {
    /// The capacity usage information for this share, including the unit of measure
    /// and
    /// quantity being used. This is
    /// `VCPU` for Amazon EC2 and `cpu` for Amazon EKS.
    capacity_usage: ?[]const FairshareCapacityUsage = null,

    /// The share identifier for the fairshare scheduling job queue.
    share_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_usage = "capacityUsage",
        .share_identifier = "shareIdentifier",
    };
};
