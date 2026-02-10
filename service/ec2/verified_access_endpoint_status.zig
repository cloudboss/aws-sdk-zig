const VerifiedAccessEndpointStatusCode = @import("verified_access_endpoint_status_code.zig").VerifiedAccessEndpointStatusCode;

/// Describes the status of a Verified Access endpoint.
pub const VerifiedAccessEndpointStatus = struct {
    /// The status code of the Verified Access endpoint.
    code: ?VerifiedAccessEndpointStatusCode,

    /// The status message of the Verified Access endpoint.
    message: ?[]const u8,
};
