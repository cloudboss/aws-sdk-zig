const VerifiedAccessEndpointPortRange = @import("verified_access_endpoint_port_range.zig").VerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes a load balancer when creating an Amazon Web Services Verified
/// Access endpoint using the
/// `load-balancer` type.
pub const VerifiedAccessEndpointLoadBalancerOptions = struct {
    /// The ARN of the load balancer.
    load_balancer_arn: ?[]const u8,

    /// The IP port number.
    port: ?i32,

    /// The port ranges.
    port_ranges: ?[]const VerifiedAccessEndpointPortRange,

    /// The IP protocol.
    protocol: ?VerifiedAccessEndpointProtocol,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8,
};
