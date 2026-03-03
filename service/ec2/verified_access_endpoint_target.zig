/// Describes the targets for the specified Verified Access endpoint.
pub const VerifiedAccessEndpointTarget = struct {
    /// The ID of the Verified Access endpoint.
    verified_access_endpoint_id: ?[]const u8 = null,

    /// The DNS name of the target.
    verified_access_endpoint_target_dns: ?[]const u8 = null,

    /// The IP address of the target.
    verified_access_endpoint_target_ip_address: ?[]const u8 = null,
};
