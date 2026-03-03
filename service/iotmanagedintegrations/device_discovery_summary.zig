const DiscoveryType = @import("discovery_type.zig").DiscoveryType;
const DeviceDiscoveryStatus = @import("device_discovery_status.zig").DeviceDiscoveryStatus;

/// Structure containing summary information about a device discovery job,
/// including its identifier, type, and status.
pub const DeviceDiscoverySummary = struct {
    /// The type of discovery process used to find devices.
    discovery_type: ?DiscoveryType = null,

    /// The unique identifier of the device discovery job.
    id: ?[]const u8 = null,

    /// The current status of the device discovery job.
    status: ?DeviceDiscoveryStatus = null,

    pub const json_field_names = .{
        .discovery_type = "DiscoveryType",
        .id = "Id",
        .status = "Status",
    };
};
