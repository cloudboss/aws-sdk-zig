const aws = @import("aws");

const RegionStatus = @import("region_status.zig").RegionStatus;

/// Status information for cross-region discovery.
pub const CrossRegionDiscoveryStatus = struct {
    /// Map of region status messages for cross-region discovery.
    message: ?[]const aws.map.MapEntry(RegionStatus),

    pub const json_field_names = .{
        .message = "Message",
    };
};
