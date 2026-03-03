const InstanceBandwidthWeighting = @import("instance_bandwidth_weighting.zig").InstanceBandwidthWeighting;

/// Configure network performance options for your instance that are geared
/// towards performance
/// improvements based on the workload that it runs.
pub const InstanceNetworkPerformanceOptionsRequest = struct {
    /// Specify the bandwidth weighting option to boost the associated type of
    /// baseline bandwidth,
    /// as follows:
    ///
    /// **default**
    ///
    /// This option uses the standard bandwidth configuration for your instance
    /// type.
    ///
    /// **vpc-1**
    ///
    /// This option boosts your networking baseline bandwidth and reduces your EBS
    /// baseline
    /// bandwidth.
    ///
    /// **ebs-1**
    ///
    /// This option boosts your EBS baseline bandwidth and reduces your networking
    /// baseline
    /// bandwidth.
    bandwidth_weighting: ?InstanceBandwidthWeighting = null,
};
