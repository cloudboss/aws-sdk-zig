const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// The connection endpoint for connecting to an Amazon Redshift cluster through
/// the proxy.
pub const VpcEndpoint = struct {
    /// One or more network interfaces of the endpoint. Also known as an interface
    /// endpoint.
    network_interfaces: ?[]const NetworkInterface = null,

    /// The connection endpoint ID for connecting an Amazon Redshift cluster through
    /// the proxy.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The VPC identifier that the endpoint is associated.
    vpc_id: ?[]const u8 = null,
};
