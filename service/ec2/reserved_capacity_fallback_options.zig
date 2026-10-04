const ReservedCapacityFallbackMarketType = @import("reserved_capacity_fallback_market_type.zig").ReservedCapacityFallbackMarketType;

/// Describes the fallback behavior for an EC2 Fleet that uses reserved capacity
/// when the
/// reserved capacity is not enough to meet the target capacity. If you don't
/// specify
/// fallback options, EC2 Fleet does not fall back to any other market type
/// after the specified
/// reservation types are exhausted.
pub const ReservedCapacityFallbackOptions = struct {
    /// The instance purchasing options to fall back to when the reserved capacity
    /// is not
    /// enough to meet the target capacity. The only supported value is `on-demand`,
    /// which launches On-Demand Instances to fulfill the remaining target capacity.
    market_types: ?[]const ReservedCapacityFallbackMarketType = null,
};
