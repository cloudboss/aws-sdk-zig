const SocketAddress = @import("socket_address.zig").SocketAddress;
const CustomRoutingDestinationTrafficState = @import("custom_routing_destination_traffic_state.zig").CustomRoutingDestinationTrafficState;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;

/// The port mappings for a specified endpoint IP address (destination).
pub const DestinationPortMapping = struct {
    /// The Amazon Resource Name (ARN) of the custom routing accelerator
    /// that you have port mappings for.
    accelerator_arn: ?[]const u8,

    /// The IP address/port combinations (sockets) that map to a given destination
    /// socket
    /// address.
    accelerator_socket_addresses: ?[]const SocketAddress,

    /// The endpoint IP address/port combination for traffic received on the
    /// accelerator socket address.
    destination_socket_address: ?SocketAddress,

    /// Indicates whether or not a port mapping destination can receive traffic. The
    /// value is either ALLOW, if
    /// traffic is allowed to the destination, or DENY, if traffic is not allowed to
    /// the destination.
    destination_traffic_state: ?CustomRoutingDestinationTrafficState,

    /// The Amazon Resource Name (ARN) of the endpoint group.
    endpoint_group_arn: ?[]const u8,

    /// The Amazon Web Services Region for the endpoint group.
    endpoint_group_region: ?[]const u8,

    /// The ID for the virtual private cloud (VPC) subnet.
    endpoint_id: ?[]const u8,

    /// The IP address type that an accelerator supports. For a custom routing
    /// accelerator, the value must be IPV4.
    ip_address_type: ?IpAddressType,

    pub const json_field_names = .{
        .accelerator_arn = "AcceleratorArn",
        .accelerator_socket_addresses = "AcceleratorSocketAddresses",
        .destination_socket_address = "DestinationSocketAddress",
        .destination_traffic_state = "DestinationTrafficState",
        .endpoint_group_arn = "EndpointGroupArn",
        .endpoint_group_region = "EndpointGroupRegion",
        .endpoint_id = "EndpointId",
        .ip_address_type = "IpAddressType",
    };
};
