const CreateVerifiedAccessEndpointPortRange = @import("create_verified_access_endpoint_port_range.zig").CreateVerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the load balancer options when creating an Amazon Web Services
/// Verified Access endpoint using the
/// `load-balancer` type.
pub const CreateVerifiedAccessEndpointLoadBalancerOptions = struct {
    /// The ARN of the load balancer.
    load_balancer_arn: ?[]const u8,

    /// The IP port number.
    port: ?i32,

    /// The port ranges.
    port_ranges: ?[]const CreateVerifiedAccessEndpointPortRange,

    /// The IP protocol.
    protocol: ?VerifiedAccessEndpointProtocol,

    /// The IDs of the subnets. You can specify only one subnet per Availability
    /// Zone.
    subnet_ids: ?[]const []const u8,
};
