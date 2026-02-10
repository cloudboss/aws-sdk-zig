const VerifiedAccessEndpointPortRange = @import("verified_access_endpoint_port_range.zig").VerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the CIDR options for a Verified Access endpoint.
pub const VerifiedAccessEndpointCidrOptions = struct {
    /// The CIDR.
    cidr: ?[]const u8,

    /// The port ranges.
    port_ranges: ?[]const VerifiedAccessEndpointPortRange,

    /// The protocol.
    protocol: ?VerifiedAccessEndpointProtocol,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8,
};
