const SocketAddress = @import("socket_address.zig").SocketAddress;
const CustomRoutingDestinationTrafficState = @import("custom_routing_destination_traffic_state.zig").CustomRoutingDestinationTrafficState;
const CustomRoutingProtocol = @import("custom_routing_protocol.zig").CustomRoutingProtocol;

/// Returns the ports and associated IP addresses and ports of Amazon EC2
/// instances in your virtual
/// private cloud (VPC) subnets. Custom routing is a port mapping protocol in
/// Global Accelerator that
/// statically associates port ranges with VPC subnets, which allows Global
/// Accelerator to route to
/// specific instances and ports within one or more subnets.
pub const PortMapping = struct {
    /// The accelerator port.
    accelerator_port: ?i32,

    /// The EC2 instance IP address and port number in the virtual private cloud
    /// (VPC) subnet.
    destination_socket_address: ?SocketAddress,

    /// Indicates whether or not a port mapping destination can receive traffic. The
    /// value is either ALLOW, if
    /// traffic is allowed to the destination, or DENY, if traffic is not allowed to
    /// the destination.
    destination_traffic_state: ?CustomRoutingDestinationTrafficState,

    /// The Amazon Resource Name (ARN) of the endpoint group.
    endpoint_group_arn: ?[]const u8,

    /// The IP address of the VPC subnet (the subnet ID).
    endpoint_id: ?[]const u8,

    /// The protocols supported by the endpoint group.
    protocols: ?[]const CustomRoutingProtocol,

    pub const json_field_names = .{
        .accelerator_port = "AcceleratorPort",
        .destination_socket_address = "DestinationSocketAddress",
        .destination_traffic_state = "DestinationTrafficState",
        .endpoint_group_arn = "EndpointGroupArn",
        .endpoint_id = "EndpointId",
        .protocols = "Protocols",
    };
};
