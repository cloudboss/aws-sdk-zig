const InstanceBandwidthWeighting = @import("instance_bandwidth_weighting.zig").InstanceBandwidthWeighting;

/// With network performance options, you can adjust your bandwidth preferences
/// to meet
/// the needs of the workload that runs on your instance.
pub const InstanceNetworkPerformanceOptions = struct {
    /// When you configure network bandwidth weighting, you can boost your baseline
    /// bandwidth for either
    /// networking or EBS by up to 25%. The total available baseline bandwidth for
    /// your instance remains
    /// the same. The default option uses the standard bandwidth configuration for
    /// your instance type.
    bandwidth_weighting: ?InstanceBandwidthWeighting,
};
