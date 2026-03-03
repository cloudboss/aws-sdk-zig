const LicenseEndpointStatus = @import("license_endpoint_status.zig").LicenseEndpointStatus;

/// The details for a license endpoint.
pub const LicenseEndpointSummary = struct {
    /// The license endpoint ID.
    license_endpoint_id: ?[]const u8 = null,

    /// The status of the license endpoint.
    status: ?LicenseEndpointStatus = null,

    /// The status message of the license endpoint.
    status_message: ?[]const u8 = null,

    /// The VPC (virtual private cloud) ID associated with the license endpoint.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_endpoint_id = "licenseEndpointId",
        .status = "status",
        .status_message = "statusMessage",
        .vpc_id = "vpcId",
    };
};
