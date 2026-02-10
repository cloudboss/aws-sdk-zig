const ModifyVerifiedAccessEndpointPortRange = @import("modify_verified_access_endpoint_port_range.zig").ModifyVerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes a load balancer when creating an Amazon Web Services Verified
/// Access endpoint using the
/// `load-balancer` type.
pub const ModifyVerifiedAccessEndpointLoadBalancerOptions = struct {
    /// The IP port number.
    port: ?i32,

    /// The port ranges.
    port_ranges: ?[]const ModifyVerifiedAccessEndpointPortRange,

    /// The IP protocol.
    protocol: ?VerifiedAccessEndpointProtocol,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8,
};
