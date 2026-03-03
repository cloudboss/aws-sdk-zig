const InstanceBandwidthWeighting = @import("instance_bandwidth_weighting.zig").InstanceBandwidthWeighting;

/// With network performance options, you can adjust your bandwidth preferences
/// to meet
/// the needs of the workload that runs on your instance at launch.
pub const LaunchTemplateNetworkPerformanceOptions = struct {
    /// When you configure network bandwidth weighting, you can boost baseline
    /// bandwidth for
    /// either networking or EBS by up to 25%. The total available baseline
    /// bandwidth for your
    /// instance remains the same. The default option uses the standard bandwidth
    /// configuration
    /// for your instance type.
    bandwidth_weighting: ?InstanceBandwidthWeighting = null,
};
