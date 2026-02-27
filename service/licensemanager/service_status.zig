const CrossAccountDiscoveryServiceStatus = @import("cross_account_discovery_service_status.zig").CrossAccountDiscoveryServiceStatus;
const CrossRegionDiscoveryStatus = @import("cross_region_discovery_status.zig").CrossRegionDiscoveryStatus;

/// Overall service status information for License Manager.
pub const ServiceStatus = struct {
    /// Status of cross-account discovery service.
    cross_account_discovery: ?CrossAccountDiscoveryServiceStatus,

    /// Status of cross-region discovery service.
    cross_region_discovery: ?CrossRegionDiscoveryStatus,

    pub const json_field_names = .{
        .cross_account_discovery = "CrossAccountDiscovery",
        .cross_region_discovery = "CrossRegionDiscovery",
    };
};
