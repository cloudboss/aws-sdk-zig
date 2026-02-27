const DiscoveryType = @import("discovery_type.zig").DiscoveryType;
const DeviceDiscoveryStatus = @import("device_discovery_status.zig").DeviceDiscoveryStatus;

/// Structure containing summary information about a device discovery job,
/// including its identifier, type, and status.
pub const DeviceDiscoverySummary = struct {
    /// The type of discovery process used to find devices.
    discovery_type: ?DiscoveryType,

    /// The unique identifier of the device discovery job.
    id: ?[]const u8,

    /// The current status of the device discovery job.
    status: ?DeviceDiscoveryStatus,

    pub const json_field_names = .{
        .discovery_type = "DiscoveryType",
        .id = "Id",
        .status = "Status",
    };
};
