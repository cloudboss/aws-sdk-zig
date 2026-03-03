const CreateVerifiedAccessEndpointPortRange = @import("create_verified_access_endpoint_port_range.zig").CreateVerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the CIDR options for a Verified Access endpoint.
pub const CreateVerifiedAccessEndpointCidrOptions = struct {
    /// The CIDR.
    cidr: ?[]const u8 = null,

    /// The port ranges.
    port_ranges: ?[]const CreateVerifiedAccessEndpointPortRange = null,

    /// The protocol.
    protocol: ?VerifiedAccessEndpointProtocol = null,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8 = null,
};
