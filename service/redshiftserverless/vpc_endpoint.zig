const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// The connection endpoint for connecting to Amazon Redshift Serverless through
/// the proxy.
pub const VpcEndpoint = struct {
    /// One or more network interfaces of the endpoint. Also known as an interface
    /// endpoint.
    network_interfaces: ?[]const NetworkInterface,

    /// The connection endpoint ID for connecting to Amazon Redshift Serverless.
    vpc_endpoint_id: ?[]const u8,

    /// The VPC identifier that the endpoint is associated with.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .network_interfaces = "networkInterfaces",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_id = "vpcId",
    };
};
