const ModifyVerifiedAccessEndpointPortRange = @import("modify_verified_access_endpoint_port_range.zig").ModifyVerifiedAccessEndpointPortRange;

/// The CIDR options for a Verified Access endpoint.
pub const ModifyVerifiedAccessEndpointCidrOptions = struct {
    /// The port ranges.
    port_ranges: ?[]const ModifyVerifiedAccessEndpointPortRange,
};
