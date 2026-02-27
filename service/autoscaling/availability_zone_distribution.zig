const CapacityDistributionStrategy = @import("capacity_distribution_strategy.zig").CapacityDistributionStrategy;

/// Describes an Availability Zone distribution.
pub const AvailabilityZoneDistribution = struct {
    /// If launches fail in an Availability Zone, the following strategies are
    /// available. The default is `balanced-best-effort`.
    ///
    /// * `balanced-only` - If launches fail in an Availability Zone, Auto Scaling
    ///   will continue to attempt to launch in the unhealthy zone to preserve a
    ///   balanced distribution.
    ///
    /// * `balanced-best-effort` - If launches fail in an Availability Zone, Auto
    ///   Scaling will attempt to launch in another healthy Availability Zone
    ///   instead.
    capacity_distribution_strategy: ?CapacityDistributionStrategy,
};
