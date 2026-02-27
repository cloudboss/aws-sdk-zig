const LicenseServerHealthStatus = @import("license_server_health_status.zig").LicenseServerHealthStatus;
const LicenseServerEndpointProvisioningStatus = @import("license_server_endpoint_provisioning_status.zig").LicenseServerEndpointProvisioningStatus;

/// Information about a Remote Desktop Services (RDS) license server.
pub const LicenseServer = struct {
    /// The health status of the RDS license server.
    health_status: ?LicenseServerHealthStatus,

    /// A list of domain IPv4 addresses that are used for the RDS license server.
    ipv_4_address: ?[]const u8,

    /// A list of domain IPv6 addresses that are used for the RDS license server.
    ipv_6_address: ?[]const u8,

    /// The current state of the provisioning process for the RDS license server.
    provisioning_status: ?LicenseServerEndpointProvisioningStatus,

    pub const json_field_names = .{
        .health_status = "HealthStatus",
        .ipv_4_address = "Ipv4Address",
        .ipv_6_address = "Ipv6Address",
        .provisioning_status = "ProvisioningStatus",
    };
};
