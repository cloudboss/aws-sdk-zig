const BandwidthWeightingEnum = @import("bandwidth_weighting_enum.zig").BandwidthWeightingEnum;

/// Configures network performance settings for WorkSpace Instance.
pub const InstanceNetworkPerformanceOptionsRequest = struct {
    /// Defines bandwidth allocation strategy for network interfaces.
    bandwidth_weighting: ?BandwidthWeightingEnum = null,

    pub const json_field_names = .{
        .bandwidth_weighting = "BandwidthWeighting",
    };
};
