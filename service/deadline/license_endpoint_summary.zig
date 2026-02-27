const LicenseEndpointStatus = @import("license_endpoint_status.zig").LicenseEndpointStatus;

/// The details for a license endpoint.
pub const LicenseEndpointSummary = struct {
    /// The license endpoint ID.
    license_endpoint_id: ?[]const u8,

    /// The status of the license endpoint.
    status: ?LicenseEndpointStatus,

    /// The status message of the license endpoint.
    status_message: ?[]const u8,

    /// The VPC (virtual private cloud) ID associated with the license endpoint.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .license_endpoint_id = "licenseEndpointId",
        .status = "status",
        .status_message = "statusMessage",
        .vpc_id = "vpcId",
    };
};
